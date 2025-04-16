// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LandRegistry {

    struct Land {
        uint256 landId;
        string ipfsHash;
        address owner;
        bool isForSale;
        uint256 price;
    }

    uint256 public landCounter;
    mapping(uint256 => Land) public lands;

    // Event when land is registered
    event LandRegistered(uint256 landId, string ipfsHash, address owner, uint256 price);
    
    // Event when land is bought
    event LandBought(uint256 landId, address newOwner, uint256 price);

    // Register land
    function registerLand(string memory _ipfsHash, uint256 _price) public {
        landCounter++;
        lands[landCounter] = Land({
            landId: landCounter,
            ipfsHash: _ipfsHash,
            owner: msg.sender,
            isForSale: true,
            price: _price
        });

        emit LandRegistered(landCounter, _ipfsHash, msg.sender, _price);
    }

    // Buy land
    function buyLand(uint256 _landId) public payable {
        Land storage land = lands[_landId];
        require(land.isForSale, "Land is not for sale");
        require(msg.value >= land.price, "Insufficient funds to buy the land");

        address previousOwner = land.owner;
        land.owner = msg.sender;
        land.isForSale = false;

        // Transfer funds to the previous owner
        payable(previousOwner).transfer(msg.value);

        emit LandBought(_landId, msg.sender, land.price);
    }

    // Put land for sale
    function putLandForSale(uint256 _landId, uint256 _price) public {
        Land storage land = lands[_landId];
        require(land.owner == msg.sender, "You are not the owner");
        land.isForSale = true;
        land.price = _price;
    }
}
