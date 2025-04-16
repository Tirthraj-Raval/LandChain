// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Verifier {
    address public authority;

    mapping(bytes32 => bool) public verifiedDocuments; // IPFS hash → verified status

    constructor() {
        authority = msg.sender;
    }

    modifier onlyAuthority() {
        require(msg.sender == authority, "Not authorized");
        _;
    }

    function verifyDocument(bytes32 docHash) public onlyAuthority {
        verifiedDocuments[docHash] = true;
    }

    function isVerified(bytes32 docHash) public view returns (bool) {
        return verifiedDocuments[docHash];
    }
}
