const LandNFT = artifacts.require("LandNFT");
const LandRegistry = artifacts.require("LandRegistry");
module.exports = async function (deployer, network, accounts) {
  const taxDepartment = accounts[2]; // hardcode tax department as per your logic
  const registrarOffice = accounts[3];

  // 1. Deploy LandNFT with tax department address
  await deployer.deploy(LandNFT, taxDepartment, registrarOffice);
  const landNFTInstance = await LandNFT.deployed();

  // 2. Deploy LandRegistry and link it with LandNFT address
  await deployer.deploy(LandRegistry, landNFTInstance.address);
};
