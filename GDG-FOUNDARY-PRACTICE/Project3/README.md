# Project 3 — Owner Message Board

A simple **owner-controlled message board** smart contract where only the contract owner can update a message stored on the blockchain. This project demonstrates **Solidity access control**, **events**, and **unit testing with Foundry**.

---

## 📖 About the Project

The **Owner Message Board** is a Solidity smart contract built using **Foundry**.  
The contract stores a message on-chain and allows **only the contract owner** to update it.

Whenever the message is updated, the contract **emits an event**, allowing off-chain applications and users to track changes.

The project includes **unit tests** to ensure the contract behaves correctly and securely.

---

## 🎯 Learning Goals

This project demonstrates:

- Solidity constructors
- Owner-based access control
- Emitting events in Solidity
- Using `require()` for permission validation
- Writing tests using **Foundry**
- Testing revert conditions and event emission

---

## ⚙️ Features

### Owner Features

- **Set Owner:** Owner is automatically set when the contract is deployed
- **Update Message:** Only the owner can change the message

### Public Features

- **Read Message:** Anyone can read the current message
- **Event Logging:** Message updates emit an event

### Security

- **Access Control:** Only the owner can update the message
- **Revert Protection:** Non-owner updates revert with an error

---

## 🛠️ Technology Stack

- **Solidity:** ^0.8.33
- **Development Tool:** Foundry (`forge`)
- **Testing Framework:** Forge Std (`Test.sol`)
- **Local Blockchain:** Anvil

---

## 📂 Project Structure

```text
Project3/
├── src/
│   └── OwnerMessageBoard.sol
├── test/
│   └── OwnerMessageBoard.t.sol
├── foundry.toml
├── foundry.lock
└── README.md
```

---

## 📜 Smart Contract Design

### State Variables

```solidity
address public owner;
string public message;
```

### Event

```solidity
event MessageUpdated(string newMessage);
```

### Core Function

| Function                | Description                      |
| ----------------------- | -------------------------------- |
| `updateMessage(string)` | Updates the message (owner only) |

### Access Control

```solidity
require(msg.sender == owner, "Not owner");
```

---

## 🧪 Testing

Tests are written using **Foundry forge test framework**.

### Test Cases

| Test                         | Description                                  |
| ---------------------------- | -------------------------------------------- |
| `testOwnerCanUpdate()`       | Verifies owner can update the message        |
| `testNonOwnerCannotUpdate()` | Ensures non-owner transactions revert        |
| `testEventEmitted()`         | Verifies the MessageUpdated event is emitted |

---

## 🚀 Compile & Run Tests

Compile the project:

```bash
forge build
```

Run tests:

```bash
forge test -vv
```

Expected result:

```text
[PASS] testOwnerCanUpdate()
[PASS] testNonOwnerCannotUpdate()
[PASS] testEventEmitted()
```

---

## 🧠 Key Concepts Learned

- Solidity constructors
- Smart contract ownership
- Access control using `require`
- Emitting events
- Testing smart contracts with Foundry

---

## 📌 Submission Checklist

```text
OwnerMessageBoard.sol (smart contract source code)

OwnerMessageBoard.t.sol (unit tests)

All tests passing using forge test

Compiled without warnings
```

---

👤 Author  
Yihalem M

---

📄 License  
MIT License
