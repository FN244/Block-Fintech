# Decentralized NFT Marketplace

A simple decentralized NFT marketplace supporting ERC-721 tokens.

## Features

- Mint NFTs
- List NFTs for sale
- Buy NFTs
- View marketplace listings

## Project Structure

- `contracts/Marketplace.sol` — Solidity smart contract for NFT marketplace
- `frontend/package.json` — React frontend dependencies
- `frontend/src/App.js` — Main dApp logic
- `frontend/src/MarketplaceABI.json` — ABI for Marketplace contract

## Setup

1. **Smart Contracts:**
    - Compile and deploy `Marketplace.sol`
    - Copy ABI to `frontend/src/MarketplaceABI.json`
    - Update contract address in `frontend/src/App.js`

2. **Frontend:**
    - `cd frontend`
    - `npm install`
    - `npm start`

## License

MIT