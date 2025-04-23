const pinataSDK = require("@pinata/sdk");
const fs = require("fs");
const path = require("path");

// Initialize Pinata client (you can also use environment variables if needed)
const pinata = new pinataSDK(
  "5733d64b0063096c9fa0",
  "4c9482b4d93fa9e7a1c0788b6dcd1294426f5d7db131b3a8aaf34f9a784aeae4"
);

/**
 * Uploads a document to IPFS via Pinata.
 * @param {string} filePath - The path to the document.
 * @returns {Promise<string>} - Returns the IPFS hash (CID) of the uploaded file.
 */
async function uploadDocument(filePath) {
  const readableStream = fs.createReadStream(filePath);

  const fileName = path.basename(filePath);

  const options = {
    pinataMetadata: {
      name: fileName,
    },
    pinataOptions: {
      cidVersion: 0,
    },
  };

  try {
    const result = await pinata.pinFileToIPFS(readableStream, options);
    console.log("IPFS Hash:", result.IpfsHash);
    console.log(
      "🌐 View File: https://gateway.pinata.cloud/ipfs/" + result.IpfsHash
    );
    return result.IpfsHash;
  } catch (err) {
    console.error("Upload failed:", err);
    throw err;
  }
}

module.exports = uploadDocument;
