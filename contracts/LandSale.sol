// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract LandNFT is ERC721URIStorage {
    address public owner;
    uint256 private _tokenIdCounter; // A simple counter for token IDs
    mapping(uint256 => uint256) public landPrices; // Mapping from tokenId to price in wei
    mapping(uint256 => address) public landSellers; // Mapping from tokenId to seller address

    event LandListed(uint256 indexed tokenId, uint256 price, address indexed seller);
    event LandPurchased(uint256 indexed tokenId, uint256 price, address indexed buyer);

    modifier onlyOwnerOf(uint256 tokenId) {
        require(ownerOf(tokenId) == msg.sender, "Not the owner of the land");
        _;
    }

    modifier onlySeller(uint256 tokenId) {
        require(landSellers[tokenId] == msg.sender, "Not the seller of the land");
        _;
    }

    modifier hasPrice(uint256 tokenId) {
        require(landPrices[tokenId] > 0, "Price not set for this land");
        _;
    }

    constructor() ERC721("LandNFT", "LNFT") {
        owner = msg.sender;
        _tokenIdCounter = 0; // Start the tokenId counter from 0
    }

    // Mint a new land NFT
    function mintLandNFT(address to, string memory tokenURI) public returns (uint256) {
        uint256 tokenId = _tokenIdCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _tokenIdCounter++; // Increment tokenId counter manually after minting
        return tokenId;
    }

    // List the land for sale with a price (in ETH)
    function listLandForSale(uint256 tokenId, uint256 price) public onlyOwnerOf(tokenId) {
        landPrices[tokenId] = price * 1 ether; // Convert ETH to wei
        landSellers[tokenId] = msg.sender;
        emit LandListed(tokenId, price, msg.sender);
    }

    // Buy the land by sending the required ETH
    function buyLand(uint256 tokenId) public payable hasPrice(tokenId) {
        uint256 price = landPrices[tokenId];
        address seller = landSellers[tokenId];

        require(msg.value >= price, "Insufficient payment");

        // Transfer the land NFT to the buyer
        _transfer(seller, msg.sender, tokenId);

        // Transfer the ETH payment to the seller
        payable(seller).transfer(price);

        // Refund any extra ETH sent
        if (msg.value > price) {
            payable(msg.sender).transfer(msg.value - price);
        }

        // Reset the listing
        landPrices[tokenId] = 0;
        landSellers[tokenId] = address(0);

        emit LandPurchased(tokenId, price, msg.sender);
    }
}
