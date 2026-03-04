# Project 2 — Simple Vault

A simple Ethereum **ETH Vault** smart contract that allows users to **deposit and withdraw their ETH securely**. This project demonstrates **Solidity basics**, **user-specific balances**, and **unit testing with Foundry**.

---

## 📖 About the Project

The **Simple Vault** smart contract is a Solidity project built with **Foundry**. Each user can **deposit ETH** and withdraw **only their own balance**. The contract ensures that users **cannot withdraw more than their balance** and **resets balances after withdrawal**. All actions are **enforced using require statements** for safety and reliability.

The project includes **unit tests** to verify functionality and a **deployment script** for local testing.

---

## 🎯 Learning Goals

This project demonstrates:

- Solidity fundamentals: mappings, functions, and events
- Tracking user-specific ETH balances using `mapping(address => uint256)`
- Input validation with `require()`
- Writing unit tests with **Foundry** (`forge test`)
- Deploying and interacting with contracts locally using `forge` and `anvil`

---

## ⚙️ Features

### User Features

- **Deposit ETH:** Users can send ETH to the contract and update their balance
- **Withdraw ETH:** Users can withdraw their own ETH only
- **Balance Tracking:** Each user's balance is stored separately
- **Revert on Invalid Withdrawal:** Prevents withdrawing without sufficient balance

### Optional Features

- **Events:** Emitting events on deposit and withdrawal for transparency

---

## 🛠️ Technology Stack

- **Solidity:** ^0.8.33
- **Development Tool:** Foundry (forge, cast, anvil)
- **Local Blockchain:** Anvil
- **Testing Framework:** Forge Std (`Test.sol`)

---

## 📂 Project Structure

```text
Project2/
├── src/
│   └── ETHVault.sol
├── test/
│   └── ETHVault.t.sol
├── script/
│   └── ETHVault.s.sol
├── foundry.toml
├── foundry.lock
└── README.md

```

## 📜 Smart Contract Design

- **balances:** `mapping(address => uint256)` storing each user’s ETH balance

### Core Functions

| Function       | Description                           |
| -------------- | ------------------------------------- |
| `deposit()`    | Allows a user to deposit ETH          |
| `withdraw()`   | Allows a user to withdraw their ETH   |
| `getBalance()` | Returns the current balance of a user |

```

```

Security: Users can withdraw only their own balance. Withdrawals without balance are reverted.

### Deployment & Testing

1. Start local blockchain:

```text
anvil
```

2. Compile & Test Contract

```text
forge build
forge test -vv
```

✅ Tests verify:

```text
Deposit updates balance

Withdraw transfers ETH

Withdraw without balance reverts
```

3. Deploy Contract Locally

```text
forge script script/ETHVault.s.sol \
 --rpc-url http://127.0.0.1:8545 \
 --private-key <YOUR_ANVIL_KEY> \
 --broadcast
```

4. Interact with Contract

Deposit ETH

```text
cast send <CONTRACT_ADDRESS> "deposit()" \
 --value <AMOUNT_IN_WEI> \
 --private-key <YOUR_ANVIL_KEY> \
 --rpc-url http://127.0.0.1:8545
```

Withdraw ETH

```text
cast send <CONTRACT_ADDRESS> "withdraw(uint256)" <AMOUNT_IN_WEI> \
 --private-key <YOUR_ANVIL_KEY> \
 --rpc-url http://127.0.0.1:8545
```

Check Balance

```text
cast call <CONTRACT_ADDRESS> "getBalance(address)" <USER_ADDRESS> \
 --rpc-url http://127.0.0.1:8545
```

### Submission Checklist

```text
ETHVault.sol (smart contract source code)

ETHVault.t.sol (unit tests)

ETHVault.s.sol (deployment script)

Deployed contract address

Test results from forge test
```

👤 Author

Yihalem M

📄 License

MIT License
