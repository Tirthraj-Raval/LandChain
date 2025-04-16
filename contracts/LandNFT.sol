// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract LandNFT is ERC721URIStorage {

    uint256 private tokenIdCounter;
    mapping(uint256 => uint256) public landPrices;
    mapping(uint256 => address) public landSellers;

    constructor() ERC721("LandNFT", "LND") {
        tokenIdCounter = 0;
    }

    // Function to mint land NFT
    function mintLandNFT(address to, string memory tokenURI) public returns (uint256) {
        uint256 tokenId = tokenIdCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI); // Sets the token URI for the minted NFT
        tokenIdCounter += 1;
        return tokenId;
    }

    // Function to list land for sale
    function listLandForSale(uint256 tokenId, uint256 price) public {
        require(ownerOf(tokenId) == msg.sender, "Message from Registar Office : You are not the owner of the land.");
        require(price > 0, "Price must be greater than zero.");
        
        landPrices[tokenId] = price;
        landSellers[tokenId] = msg.sender;
    }

    // Function to buy land
    function buyLand(uint256 tokenId) public payable {
        uint256 price = landPrices[tokenId];
        address seller = landSellers[tokenId];

        require(price > 0, "This land is not for sale.");
        require(msg.value >= price, "Not enough ETH sent.");
        require(seller != msg.sender, "You cannot buy your own land.");

        // Transfer the ETH to the seller
        payable(seller).transfer(msg.value);

        // Transfer the ownership of the land
        _transfer(seller, msg.sender, tokenId);

        // Reset the sale status
        landPrices[tokenId] = 0;
        landSellers[tokenId] = address(0);
    }

    // Function to get the total number of tokens minted
    function getTokenCount() public view returns (uint256) {
        return tokenIdCounter;
    }
}
