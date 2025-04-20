// scripts/uploadToIPFS.js
const pinataSDK = require("@pinata/sdk");
const fs = require("fs");
const path = require("path");

const pinata = new pinataSDK(
  "5733d64b0063096c9fa0",
  "4c9482b4d93fa9e7a1c0788b6dcd1294426f5d7db131b3a8aaf34f9a784aeae4"
);

async function uploadDocument(filepath) {
  const readableStreamForFile = fs.createReadStream(filepath);

  const result = await pinata.pinFileToIPFS(readableStreamForFile, {
    pinataMetadata: { name: path.basename(filepath) },
  });

  console.log("✅ IPFS Hash:", result.IpfsHash);
  console.log(
    "🔗 URL:",
    `https://gateway.pinata.cloud/ipfs/${result.IpfsHash}`
  );
  return result.IpfsHash;
}

// Example usage:
(async () => {
  const hash = await uploadDocument(
    "./Project guideline- TOD212 Decision Sciences- Winter 2025.pdf"
  );
})();

module.exports = { uploadDocument };

//API-KEY : 5733d64b0063096c9fa0
//API-SECRET : 4c9482b4d93fa9e7a1c0788b6dcd1294426f5d7db131b3a8aaf34f9a784aeae4
//JWT : eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySW5mb3JtYXRpb24iOnsiaWQiOiIzNzc2YjVkMS04NGFjLTQ3ZDMtODgwYi01MTAyZDBjODE0ZWQiLCJlbWFpbCI6Im5haXRpay5zQGFoZHVuaS5lZHUuaW4iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicGluX3BvbGljeSI6eyJyZWdpb25zIjpbeyJkZXNpcmVkUmVwbGljYXRpb25Db3VudCI6MSwiaWQiOiJGUkExIn0seyJkZXNpcmVkUmVwbGljYXRpb25Db3VudCI6MSwiaWQiOiJOWUMxIn1dLCJ2ZXJzaW9uIjoxfSwibWZhX2VuYWJsZWQiOmZhbHNlLCJzdGF0dXMiOiJBQ1RJVkUifSwiYXV0aGVudGljYXRpb25UeXBlIjoic2NvcGVkS2V5Iiwic2NvcGVkS2V5S2V5IjoiNTczM2Q2NGIwMDYzMDk2YzlmYTAiLCJzY29wZWRLZXlTZWNyZXQiOiI0Yzk0ODJiNGQ5M2ZhOWU3YTFjMDc4OGI2ZGNkMTI5NDQyNmY1ZDdkYjEzMWIzYThhYWYzNGY5YTc4NGFlYWU0IiwiZXhwIjoxNzc2NzExMTQzfQ.7ZerKAeN6K0OXN8kxUZK7vZ62H7XMvtKCKHkh-p0ZpE
