# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```

# WhitelistNFT

## Project Summary
WhitelistNFT is an ERC721 NFT smart contract that allows only whitelisted users to mint NFTs, and each whitelisted user can mint only one NFT. The contract is built using OpenZeppelin libraries for security and best practices, and the project is managed and tested using Hardhat.

## What It Does
- Only addresses added to the whitelist by the contract owner can mint NFTs.
- Each whitelisted address can mint only one NFT.
- The contract owner can add single or multiple addresses to the whitelist.
- Uses OpenZeppelin's ERC721 implementation for secure and standard NFT functionality.

## Tools Used
- **Hardhat**: Development environment for compiling, testing, and deploying smart contracts.
- **OpenZeppelin**: Secure, community-vetted smart contract libraries (ERC721, Ownable, etc.).

## Steps to Deploy
1. **Install dependencies:**
   ```bash
   npm install
   ```
2. **Compile contracts:**
   ```bash
   npx hardhat compile
   ```
3. **Run tests (optional, but recommended):**
   ```bash
   npx hardhat test
   ```
4. **Deploy contract using Hardhat Ignition:**
   ```bash
   npx hardhat ignition deploy ./ignition/modules/whitelistnft.js
   ```
   This will deploy the WhitelistNFT contract and set the deployer as the initial owner.

---
Built with ❤️ using Hardhat and OpenZeppelin.
