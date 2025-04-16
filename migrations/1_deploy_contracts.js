const LandNFT = artifacts.require("LandNFT");
const LandRegistry = artifacts.require("LandRegistry");

module.exports = async function (deployer) {
  // Deploy LandNFT contract first
  await deployer.deploy(LandNFT);
  const landNFTInstance = await LandNFT.deployed();

  // Deploy LandRegistry contract and link it with LandNFT
  await deployer.deploy(LandRegistry, landNFTInstance.address);
};
