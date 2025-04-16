const { create } = require('ipfs-http-client');
const fs = require('fs');

// Connect to IPFS
const ipfs = create({ url: 'https://ipfs.infura.io:5001/api/v0' });

// Upload file to IPFS
async function uploadFileToIPFS(filePath) {
    try {
        const file = fs.readFileSync(filePath);
        const added = await ipfs.add(file);
        console.log('File uploaded to IPFS: ', added.path);
        return added.path;
    } catch (error) {
        console.log('Error uploading file to IPFS: ', error);
    }
}

// Example usage:
(async () => {
    const ipfsUrl = await uploadFileToIPFS('./path/to/your/land-document.pdf'); // Replace with actual file path
    console.log('IPFS URL:', ipfsUrl);
})();
