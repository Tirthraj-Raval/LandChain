// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract LandNFT is ERC721URIStorage {
    uint256 private tokenIdCounter;
    mapping(uint256 => uint256) public landPrices;
    mapping(uint256 => address) public landSellers;

    // new change for tax
    address public taxDepartment; // tax authority
    mapping(uint256 => uint256) public landTaxes; // stores 10% tax per listing
    mapping(uint256 => uint256) public netPrices; // total price (price + tax)

    constructor() ERC721("LandNFT", "LND") {
        tokenIdCounter = 0;
        taxDepartment = msg.sender; // deployer is tax dept for now
    }

    // Function to mint land NFT
    function mintLandNFT(
        address to,
        string memory tokenURI
    ) public returns (uint256) {
        uint256 tokenId = tokenIdCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        tokenIdCounter += 1;
        return tokenId;
    }

    // Function to list land for sale
    function listLandForSale(uint256 tokenId, uint256 price) public {
        require(
            ownerOf(tokenId) == msg.sender,
            "Message from Registrar Office: You are not the owner of the land."
        );
        require(price > 0, "Price must be greater than zero.");

        landPrices[tokenId] = price;
        landSellers[tokenId] = msg.sender;

        // new change for tax
        uint256 tax = (price * 10) / 100; // 10% tax
        landTaxes[tokenId] = tax;
        netPrices[tokenId] = price + tax; // total amount to be paid by buyer
    }

    event LandPurchaseDetails(
        uint256 tokenId,
        uint256 price,
        uint256 tax,
        uint256 netPrice,
        address buyer
    );

    // Function to buy land
    function buyLand(uint256 tokenId) public payable {
        uint256 price = landPrices[tokenId];
        address seller = landSellers[tokenId];
        uint256 tax = landTaxes[tokenId];
        uint256 netPrice = netPrices[tokenId];

        require(price > 0, "This land is not for sale.");
        require(
            msg.value >= netPrice,
            "Not enough ETH sent (need to pay price + tax)."
        );
        require(seller != msg.sender, "You cannot buy your own land.");

        // 🔒 Ensure contract balance is sufficient before transferring
        require(
            address(this).balance >= netPrice,
            "Contract has insufficient balance."
        );

        emit LandPurchaseDetails(tokenId, price, tax, netPrice, msg.sender);

        // 1. Pay seller only the land price
        (bool sentToSeller, ) = payable(seller).call{value: price}("");
        require(sentToSeller, "Payment to seller failed");

        // 2. Pay tax department
        // (bool sentToTax, ) = payable(taxDepartment).call{value: tax}("");
        // require(sentToTax, "Payment to tax department failed");

        // 3. Transfer ownership of NFT
        _transfer(seller, msg.sender, tokenId);

        // 4. Reset mappings
        landPrices[tokenId] = 0;
        landSellers[tokenId] = address(0);
        landTaxes[tokenId] = 0;
        netPrices[tokenId] = 0;

        // 5. Emit event to trace on frontend or Etherscan
    }

    // Function to get the total number of tokens minted
    function getTokenCount() public view returns (uint256) {
        return tokenIdCounter;
    }
}
