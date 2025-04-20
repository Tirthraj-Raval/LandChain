const pinataSDK = require('@pinata/sdk');
const fs = require('fs');

// Initialize Pinata client
const pinata = new pinataSDK(
  '5733d64b0063096c9fa0',
  '4c9482b4d93fa9e7a1c0788b6dcd1294426f5d7db131b3a8aaf34f9a784aeae4'
);

// File stream for your land document
const readableStream = fs.createReadStream('./JETIR2304754.pdf');

// 👇 Add metadata to include a name for the file
const options = {
  pinataMetadata: {
    name: 'Land_Document_JETIR2304754'
  },
  pinataOptions: {
    cidVersion: 0
  }
};

pinata.pinFileToIPFS(readableStream, options)
  .then((result) => {
    console.log("✅ IPFS Hash:", result.IpfsHash);
    console.log("🌐 View File: https://gateway.pinata.cloud/ipfs/" + result.IpfsHash);
  })
  .catch((err) => {
    console.error("❌ Upload failed:", err);
  });
