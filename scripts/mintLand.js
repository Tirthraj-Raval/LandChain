// scripts/mintLand.js
const Web3 = require("web3");
const { uploadDocument } = require("./uploadToIPFS");
const contract = require("../build/contracts/LandNFT.json");
const path = require("path");

const web3 = new Web3("http://127.0.0.1:8545"); // Ganache URL

const account = "0xYourDeployerAccount"; // 👈 Replace with your actual account from Ganache

const contractAddress = "0xYourDeployedContractAddress"; // 👈 Replace with deployed contract address

async function main() {
  const landNFT = new web3.eth.Contract(contract.abi, contractAddress);

  // Upload document to IPFS
  const filepath =
    "./Project guideline- TOD212 Decision Sciences- Winter 2025.pdf";
  const tokenURI = await uploadDocument(filepath); // get IPFS URL

  // Call mintLandNFT
  const gasEstimate = await landNFT.methods
    .mintLandNFT(account, tokenURI)
    .estimateGas({ from: account });

  const receipt = await landNFT.methods.mintLandNFT(account, tokenURI).send({
    from: account,
    gas: gasEstimate,
  });

  console.log("✅ NFT Minted. Transaction Hash:", receipt.transactionHash);
}

main().catch((err) => {
  console.error("❌ Error:", err);
});
