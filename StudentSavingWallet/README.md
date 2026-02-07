# Decentralized Student Savings Wallet (DSSW)

A simple Ethereum smart contract that allows students to securely save, withdraw, and track ETH in a decentralized manner. The project demonstrates practical Web3 concepts such as self-custody, transparency, and trustless execution.

---

## 📖 About the Project

The **Decentralized Student Savings Wallet (DSSW)** is a Solidity-based smart contract designed to simulate a real-world decentralized savings system. Users can deposit ETH, withdraw funds when required, and view their transaction history directly on the blockchain.

The wallet operates without intermediaries. All funds remain under the control of the user’s Ethereum address, and every transaction is permanently recorded on the Ethereum blockchain. The contract is deployed on the **Sepolia Ethereum Testnet** and interacted with using **MetaMask** and **Remix IDE**.

---

## 🎯 Learning Goals

This project demonstrates:

- Wallet ownership and user control in decentralized systems
- Solidity fundamentals such as mappings, structs, arrays, and functions
- Secure handling of ETH deposits and withdrawals
- Smart contract interaction using Remix and MetaMask
- Deployment to a public Ethereum test network (Sepolia)

---

## ⚙️ Features

- Deposit ETH into a personal savings wallet
- Withdraw ETH only when sufficient balance exists
- Check wallet balance at any time
- Record deposit and withdrawal history
- Emit blockchain events for transparency

---

## 🛠️ Technology Stack

- **Solidity:** ^0.8.x
- **Development Tool:** Remix IDE
- **Wallet:** MetaMask
- **Blockchain Network:** Sepolia Ethereum Testnet
- **Platform:** Ethereum (EVM compatible)

---

## 📂 Project Structure

StudentSavingsWallet/
├── contracts/
│ └── StudentSavingsWallet.sol # Main smart contract
├── screenshots/
│ ├── deployment.png # Contract deployment proof
│ ├── deposit.png # ETH deposit interaction
│ └── withdraw.png # ETH withdrawal interaction
├── README.md # Project documentation

---

## 📜 Smart Contract Design

### Data Storage

- **Balances:** A mapping is used to store ETH balances for each user address
- **Transactions:** A struct and array are used to record deposit and withdrawal activities

### Core Functions

| Function                   | Description                                 |
| -------------------------- | ------------------------------------------- |
| `deposit()`                | Allows users to deposit ETH into the wallet |
| `withdraw(uint256 amount)` | Withdraws ETH if sufficient balance exists  |
| `checkBalance()`           | Returns the caller’s wallet balance         |
| `getTransactionHistory()`  | Returns recorded transactions               |

---

## 🔐 Security Considerations

- User balance is updated before transferring ETH to prevent reentrancy risks
- Solidity ^0.8.x includes built-in overflow and underflow protection
- Withdrawals are restricted to available balances only

---

## 🚀 Deployment Information

- **Network:** Sepolia Ethereum Testnet
- **Contract Name:** StudentSavingsWallet
- **Contract Address:** `0xYourContractAddressHere`
- **Deployment Transaction Hash:** `0xYourTransactionHashHere`

---

## 🧪 How to Use the Contract

1. Open Remix IDE in your browser
2. Connect MetaMask and switch to the Sepolia network
3. Compile and deploy the `StudentSavingsWallet` contract
4. Call `deposit()` with ETH value to save funds
5. Call `withdraw(amount)` to retrieve ETH
6. Use `checkBalance()` to view wallet balance

---

## 📸 Screenshots (Submission Evidence)

> Replace placeholders with real screenshots after deployment

- Contract deployment confirmation  
  ![Deployment Screenshot](screenshots/deployment.png)

- ETH deposit transaction  
  ![Deposit Screenshot](screenshots/deposit.png)

- ETH withdrawal transaction  
  ![Withdrawal Screenshot](screenshots/withdraw.png)

---

## 📂 Submission Checklist

- Solidity smart contract source code
- Deployed contract address
- Deployment transaction hash
- Screenshots showing successful interaction

---

## ✨ Optional Enhancements

- Minimum deposit amount
- Time-lock mechanism for withdrawals
- Admin or owner role
- Extended transaction filtering

---

## 👤 Author

**Yihalem**  
Final-Year Engineering Student  
Web3 & Blockchain Developer

---

## 📄 License

This project is licensed under the MIT License.
