# Block-Fintech: Tokenized Crowdfunding Platform

## Overview

A full-stack dApp for decentralized, token-based crowdfunding. Contributors receive ERC20 tokens proportional to their contribution. Projects can claim funds if goals are met, or contributors can refund otherwise.

## Structure

```
tokenized-crowdfunding/
├── contracts/           # Smart contracts (Solidity)
│   ├── Crowdfunding.sol
│   └── ProjectToken.sol
├── frontend/            # Web frontend (React)
│   ├── src/
│   │   ├── App.js
│   │   └── CrowdfundingABI.json
│   └── package.json
└── README.md
```

## How it works

- **Create Project:** Deploy a new crowdfunding campaign with a goal, deadline, and token parameters.
- **Fund Project:** Anyone can fund a project and receive project tokens.
- **Claim Funds:** Project owner can claim if the goal is met after deadline.
- **Refund:** Contributors can refund if the goal is not met.

## Smart Contracts

- `Crowdfunding.sol`: Main contract for campaigns, funding, claiming, refunding.
- `ProjectToken.sol`: ERC20 token for each project.

## Frontend

- React-based UI.
- Integrates with Ethereum wallet (MetaMask).
- Create projects, fund, claim, refund, and view campaigns.

## Getting Started

1. **Install dependencies**  
   ```bash
   cd frontend
   npm install
   ```

2. **Deploy contracts**  
   Use Hardhat/Remix to deploy `Crowdfunding.sol`.  
   Update `CF_ADDRESS` in `App.js` with deployed address.

3. **Start frontend**  
   ```bash
   npm start
   ```

4. **Access dApp**  
   Open `http://localhost:3000` in your browser.

## License

MIT
