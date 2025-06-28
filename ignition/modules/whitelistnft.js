const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("WhitelistNFTModule", (m) => {
  const [deployer] = m.getSigners();
  const whitelistNFT = m.contract("WhitelistNFT", [deployer]);
  return { whitelistNFT };
});
