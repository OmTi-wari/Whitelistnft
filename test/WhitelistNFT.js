const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("WhitelistNFT", function () {
  let WhitelistNFT, whitelistNFT, owner, addr1, addr2, addr3;

  beforeEach(async function () {
    [owner, addr1, addr2, addr3] = await ethers.getSigners();
    WhitelistNFT = await ethers.getContractFactory("WhitelistNFT");
    whitelistNFT = await WhitelistNFT.deploy(owner.address);
  });

  it("should allow owner to add users to whitelist", async function () {
    await whitelistNFT.addToWhitelist(addr1.address);
    expect(await whitelistNFT.whitelist(addr1.address)).to.be.true;
  });

  it("should allow owner to add batch users to whitelist", async function () {
    await whitelistNFT.addBatchToWhitelist([addr1.address, addr2.address]);
    expect(await whitelistNFT.whitelist(addr1.address)).to.be.true;
    expect(await whitelistNFT.whitelist(addr2.address)).to.be.true;
  });

  it("should allow whitelisted user to mint only once", async function () {
    await whitelistNFT.addToWhitelist(addr1.address);
    await whitelistNFT.connect(addr1).mint("ipfs://token1");
    expect(await whitelistNFT.hasMinted(addr1.address)).to.be.true;
    await expect(
      whitelistNFT.connect(addr1).mint("ipfs://token2")
    ).to.be.revertedWith("Already minted");
  });

  it("should not allow non-whitelisted user to mint", async function () {
    await expect(
      whitelistNFT.connect(addr2).mint("ipfs://token3")
    ).to.be.revertedWith("Not whitelisted");
  });
}); 