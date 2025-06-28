// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WhitelistNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    mapping(address => bool) public whitelist;
    mapping(address => bool) public hasMinted;

    constructor(address initialOwner) ERC721("WhitelistNFT", "WNFT") Ownable(initialOwner) {
        tokenCounter = 1;
    }

    function addToWhitelist(address _user) external onlyOwner {
        whitelist[_user] = true;
    }

    function addBatchToWhitelist(address[] calldata _users) external onlyOwner {
        for (uint i = 0; i < _users.length; i++) {
            whitelist[_users[i]] = true;
        }
    }

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
