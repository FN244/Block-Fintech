// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ProjectToken.sol";

contract Crowdfunding {
    struct Project {
        address payable owner;
        uint256 goal;
        uint256 deadline;
        uint256 raised;
        bool claimed;
        ProjectToken token;
        mapping(address => uint256) contributions;
    }

    uint256 public projectCount;
    mapping(uint256 => Project) public projects;
    event ProjectCreated(uint256 indexed id, address owner, uint256 goal, uint256 deadline, address token);
    event Funded(uint256 indexed id, address funder, uint256 amount);
    event Claimed(uint256 indexed id);

    function createProject(uint256 goal, uint256 duration, string memory name, string memory symbol) external {
        require(goal > 0, "Goal must be positive");
        require(duration > 0, "Duration must be positive");
        ProjectToken token = new ProjectToken(name, symbol, address(this));
        uint256 id = projectCount++;
        Project storage p = projects[id];
        p.owner = payable(msg.sender);
        p.goal = goal;
        p.deadline = block.timestamp + duration;
        p.claimed = false;
        p.token = token;

        emit ProjectCreated(id, msg.sender, goal, p.deadline, address(token));
    }

    function fundProject(uint256 id) external payable {
        Project storage p = projects[id];
        require(block.timestamp < p.deadline, "Project ended");
        require(msg.value > 0, "No ETH sent");
        p.contributions[msg.sender] += msg.value;
        p.raised += msg.value;
        // Mint project tokens proportional to ETH
        p.token.mint(msg.sender, msg.value);

        emit Funded(id, msg.sender, msg.value);
    }

    function claimFunds(uint256 id) external {
        Project storage p = projects[id];
        require(msg.sender == p.owner, "Not project owner");
        require(block.timestamp >= p.deadline, "Project not ended");
        require(p.raised >= p.goal, "Goal not reached");
        require(!p.claimed, "Already claimed");
        p.claimed = true;
        p.owner.transfer(p.raised);

        emit Claimed(id);
    }

    function refund(uint256 id) external {
        Project storage p = projects[id];
        require(block.timestamp >= p.deadline, "Project not ended");
        require(p.raised < p.goal, "Goal reached");
        uint256 contributed = p.contributions[msg.sender];
        require(contributed > 0, "No contribution");
        p.contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contributed);
    }

    function getContribution(uint256 id, address user) external view returns (uint256) {
        return projects[id].contributions[user];
    }

    function getProjectToken(uint256 id) external view returns (address) {
        return address(projects[id].token);
    }
}