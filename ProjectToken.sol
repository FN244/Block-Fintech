// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ProjectToken is ERC20 {
    address public crowdfunding;

    constructor(string memory name, string memory symbol, address _crowdfunding)
        ERC20(name, symbol)
    {
        crowdfunding = _crowdfunding;
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == crowdfunding, "Only crowdfunding contract can mint");
        _mint(to, amount);
    }
}