// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title WhitelistNFT
/// @notice ERC721 NFT that allows only whitelisted users to mint, and only once per user.
contract WhitelistNFT is ERC721URIStorage, Ownable {
    /// @notice Counter for token IDs
    uint256 public tokenCounter;
    /// @notice Mapping to track whitelisted addresses
    mapping(address => bool) public whitelist;
    /// @notice Mapping to track if an address has already minted
    mapping(address => bool) public hasMinted;

    /// @notice Constructor sets the initial owner and initializes the token counter
    /// @param initialOwner The address that will be the contract owner
    constructor(address initialOwner) ERC721("WhitelistNFT", "WNFT") Ownable(initialOwner) {
        tokenCounter = 1;
    }

    /// @notice Add a single address to the whitelist
    /// @param _user The address to whitelist
    function addToWhitelist(address _user) external onlyOwner {
        whitelist[_user] = true;
    }

    /// @notice Add multiple addresses to the whitelist in a batch
    /// @param _users The array of addresses to whitelist
    function addBatchToWhitelist(address[] calldata _users) external onlyOwner {
        for (uint i = 0; i < _users.length; i++) {
            whitelist[_users[i]] = true;
        }
    }

    /// @notice Mint an NFT if the sender is whitelisted and hasn't minted yet
    /// @param tokenURI The metadata URI for the NFT
    function mint(string memory tokenURI) external {
        require(whitelist[msg.sender], "Not whitelisted");
        require(!hasMinted[msg.sender], "Already minted");

        uint256 newTokenId = tokenCounter;
        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        hasMinted[msg.sender] = true;
        tokenCounter++;
    }
}
