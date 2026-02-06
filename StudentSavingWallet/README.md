# Student Savings Wallet (DSSW)

A decentralized Ethereum-based savings wallet built using Solidity.  
This project allows students and users to securely deposit, store, and withdraw ETH without relying on any centralized authority.  
All balances and transactions are managed on-chain, ensuring transparency, trustless execution, and user ownership.

---

## 🧠 Project Overview

The **Decentralized Student Savings Wallet (DSSW)** demonstrates core Web3 and blockchain principles such as:

- Wallet ownership through blockchain addresses
- Decentralized fund management
- Transparent and immutable transaction records
- Secure smart contract execution

Each user interacts with the contract using their own Ethereum wallet and maintains full control over their deposited funds.

---

## 🎯 Learning Objectives

- Understand decentralized wallet ownership using `msg.sender`
- Apply Solidity fundamentals: mappings, structs, arrays, and functions
- Deploy and interact with smart contracts using Remix and MetaMask
- Gain experience working with Ethereum test networks
- Build confidence in real-world Web3 smart contract development

---

## ✨ Features

- Deposit ETH into a decentralized savings wallet
- Withdraw ETH with balance validation
- Per-user balance tracking using mappings
- On-chain transaction history using structs and arrays
- Read-only functions for transparency and auditing
- Publicly verifiable deployment on Ethereum Sepolia testnet

---

## 🛠 Tech Stack

- **Solidity** ^0.8.x
- **Remix IDE**
- **MetaMask Wallet**
- **Ethereum Sepolia Testnet**
- **Git & GitHub**

---

## 📄 Smart Contract

- Contract Name: `StudentSavingsWallet`
- Language: Solidity
- License: MIT

---

## 🚀 Deployment Details (Sepolia Testnet)

> _Add these details after deployment_

- **Network:** Sepolia Testnet
- **Contract Address:** `0xYourContractAddressHere`
- **Deployment Transaction Hash:** `0xYourDeploymentTxHashHere`
- **Deployed Using:** Remix IDE

⚠️ **Note:** This contract is deployed on a testnet for educational purposes only.  
Do NOT use on Ethereum mainnet.

---

## 🧪 How to Interact With the Contract

1. Open **Remix IDE**: https://remix.ethereum.org
2. Load the contract from this GitHub repository
3. Compile using Solidity compiler ^0.8.x
4. Connect MetaMask using **Injected Provider**
5. Ensure MetaMask is on **Sepolia Testnet**
6. Deploy or attach to the deployed contract address
7. Interact with:
   - `deposit()` → Send test ETH
   - `withdraw(amount)` → Withdraw ETH
   - `getBalance()` → Check balance
   - `getTransactions()` → View transaction history

---

## 📸 Screenshots (Proof of Work)

### 1️⃣ Contract Deployment (Sepolia)

> Screenshot showing successful deployment in Remix

![Deployment Screenshot](screenshots/deployment.png)

---

### 2️⃣ ETH Deposit Transaction

> Screenshot showing ETH deposit via `deposit()` function

![Deposit Screenshot](screenshots/deposit.png)

---

### 3️⃣ Balance Check

> Screenshot showing balance returned by `getBalance()`

![Balance Screenshot](screenshots/balance.png)

---

### 4️⃣ ETH Withdrawal

> Screenshot showing successful withdrawal transaction

![Withdrawal Screenshot](screenshots/withdraw.png)

---

### 5️⃣ MetaMask Confirmation

> Screenshot showing MetaMask transaction confirmation

![MetaMask Screenshot](screenshots/metamask.png)

---

## 📁 Project Structure

StudentSavingWallet/
├── StudentSavingsWallet.sol
├── README.md
└── screenshots/
├── deployment.png
├── deposit.png
├── balance.png
├── withdraw.png
└── metamask.png

---

## 🔐 Security Considerations

- Users can only withdraw their own deposited ETH
- Balance checks prevent overdrawing
- Smart contract logic enforces trustless execution
- All transactions are publicly verifiable on-chain

---

## 👨‍🎓 Author

- **Project:** Web3 Track – Mini Project Assignment
- **Title:** Decentralized Student Savings Wallet (DSSW)
- **Developer:** \_Yihalem Mulat
- **Institution:** \_AASTU / GDG_web3

---

## 📜 License

This project is licensed under the **MIT License**.
