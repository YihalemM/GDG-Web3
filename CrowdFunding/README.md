# CrowdFunding Smart Contract

A decentralized crowdfunding smart contract built with **Solidity** and tested using **Foundry**.

This project allows anyone to create a campaign, pledge ETH to support campaigns, claim funds if the goal is reached, or receive refunds if the campaign fails.

---

# Features

- Create crowdfunding campaigns
- Pledge ETH to campaigns
- Track pledged amounts per user
- Claim funds if funding goal is reached
- Refund contributors if campaign fails
- Fully tested using Foundry

---

# Smart Contract Overview

The contract allows users to:

### 1. Create Campaign

Anyone can create a crowdfunding campaign with:

- funding goal
- campaign duration

```
create(uint256 goal, uint256 duration)
```

The campaign stores:

- owner
- funding goal
- total pledged ETH
- start time
- end time
- claim status

---

### 2. Pledge ETH

Users can support a campaign by sending ETH.

```
pledge(uint256 campaignId)
```

Rules:

- Campaign must still be active
- ETH must be greater than 0
- User pledge amount is tracked

---

### 3. Claim Funds

If the campaign **reaches its goal**, the campaign owner can claim the funds.

```
claim(uint256 campaignId)
```

Conditions:

- Only campaign owner
- Campaign must be finished
- Goal must be reached
- Funds not already claimed

---

### 4. Refund

If the campaign **fails to reach its goal**, contributors can withdraw their pledged ETH.

```
refund(uint256 campaignId)
```

Conditions:

- Campaign ended
- Goal NOT reached
- User must have pledged ETH

---

# Contract Structure

```
CrowdFund.sol
│
├── Campaign Struct
├── campaignCount
├── campaigns mapping
├── pledgedAmount mapping
│
├── create()
├── pledge()
├── claim()
└── refund()
```

---

# Tech Stack

- Solidity `^0.8.20`
- Foundry
- Anvil (local blockchain)
- Forge (testing & deployment)

---

# Project Structure

```
CrowdFunding
│
├── src
│   └── CrowdFund.sol
│
├── script
│   └── DeployCrowdFunding.s.sol
│
├── test
│   └── CrowdFund.t.sol
│
└── README.md
```

---

# How to Run the Project

### 1. Install Foundry

```
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

---

### 2. Start Local Blockchain

```
anvil
```

---

### 3. Run Tests

```
forge test -vv
```

---

### 4. Deploy Contract

```
forge script script/DeployCrowdFunding.s.sol \
--rpc-url http://127.0.0.1:8545 \
--private-key YOUR_PRIVATE_KEY \
--broadcast
```

---

# Example Workflow

1. Create campaign
2. Users pledge ETH
3. Campaign ends
4. If goal reached → owner claims
5. If goal not reached → users refund

---

# Learning Purpose

This project demonstrates important **Web3 development concepts**:

- Solidity structs
- mappings
- payable functions
- ETH transfers
- smart contract testing
- local blockchain deployment

---

# Author

**YihalemM**

---
