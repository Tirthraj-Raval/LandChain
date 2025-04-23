# LandChain: A Decentralized Land Registry System

LandChain is a blockchain-based land registry system developed as part of our Blockchain course project under the guidance of Professor Sanjay Chaudry. It leverages Ethereum smart contracts, decentralized file storage using IPFS (via Pinata), and tools like Truffle and Ganache to create a transparent, secure, and tamper-proof registry for land ownership, transactions, and verification.

---

## 🚀 Project Overview

LandChain introduces a decentralized alternative to conventional land record systems. It uses smart contracts for asset tokenization, validates ownership through a registrar office, and permanently stores documents like land deeds and ownership proofs via IPFS using Pinata. Each piece of land is represented as an NFT on the Ethereum blockchain.

---

## 📦 Features

- 🔐 Secure Land Ownership via ERC-721 NFTs
- 📄 IPFS-based document storage using Pinata
- 🏛 Role-based access for Registrar, Revenue Dept., Buyer, and Seller
- 📤 Document verification & ownership validation
- 📦 Decentralized asset tokenization with resale & ownership transfer
- 🧾 Transparent tax calculation and payment logic (10% tax)
- ✅ Real-time event logging for transactions

---

## 🧱 Tech Stack

| Layer              | Technology                         |
|-------------------|-------------------------------------|
| Smart Contracts    | Solidity, Truffle                  |
| Blockchain Network | Ethereum (Ganache Local Node)     |
| Storage            | IPFS (via Pinata)                 |
| Testing/Dev Tools  | Truffle, Ganache CLI               |
| Frontend (optional)| React / Web3.js (extendable)       |

---

## 👥 Stakeholders

| Stakeholder       | Role                                                                 |
|-------------------|----------------------------------------------------------------------|
| Seller            | Owns and lists the land for sale                                     |
| Buyer             | Views, verifies, and purchases land                                  |
| Registrar Office  | Verifies land documents and updates ownership records                |
| Revenue Department| Collects taxes and ensures legal compliance                          |

These roles interact through access-controlled smart contracts and verify transaction integrity in a decentralized manner.

---

## 📂 Why Pinata for IPFS?

Pinata offers reliable IPFS pinning services with developer-friendly APIs and persistence guarantees. Unlike public IPFS nodes which may garbage collect files, Pinata ensures:

- Files are permanently accessible via pinning
- High availability across its own IPFS infrastructure
- RESTful APIs to upload, fetch, and manage content
- Better documentation and dev tooling support

Other IPFS options:

| Service     | Pros                                   | Cons                                     |
|-------------|----------------------------------------|------------------------------------------|
| Infura      | Offers IPFS APIs, good uptime          | No native file pinning, limited free tier|
| Web3.Storage| Great free plan, built by Protocol Labs| Rate limits, slower pinning              |
| NFT.Storage | Tailored for NFTs, free up to a limit  | Requires metadata structure              |
| Pinata      | High availability, dev-friendly APIs   | Some features behind paywall             |

With Pinata, our team was able to seamlessly integrate upload and fetch logic for document verification using their API.

---

## 📸 Screenshots / Architecture

![Architecture Diagram](docs/architecture.png)
*(Replace with actual diagram showing user, smart contract, IPFS interaction)*

---

## ⚙️ Installation & Setup

### Prerequisites

- Node.js & NPM
- Truffle (`npm install -g truffle`)
- Ganache CLI or UI
- Pinata account (for IPFS API key/secret)

### Clone and Install

```bash
git clone https://github.com/yourusername/LandChain.git
cd LandChain
npm install
