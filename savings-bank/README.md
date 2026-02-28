# SavingsBank - Ethereum Smart Contract Project

A simple Ethereum **Savings Bank** smart contract using **Foundry**, allowing users to deposit and withdraw ETH safely.

---

## Features

- Users can deposit ETH.
- Tracks each user’s balance.
- Users can withdraw their own funds.
- Prevents withdrawing more than balance.
- Emits events on deposit and withdrawal.
- Check individual user balances.
- Check total ETH stored.
- **Bonus:** Withdrawal cooldown (1 minute).

---

## Project Requirements

### 1. Contract (inside `src/`)

Create `SavingsBank.sol`. Your contract must:

1. Allow users to deposit ETH.
2. Track each user’s balance using a mapping.
3. Allow users to withdraw their own funds.
4. Prevent users from withdrawing more than their balance.
5. Emit events when:
   - A deposit is made
   - A withdrawal is made
6. Include a function to check a user’s balance.
7. Include a function that returns the total ETH stored in the contract.

---

### 2. Testing (inside `test/`)

Write a test file for the contract. Your tests must verify:

- A user can deposit ETH successfully.
- The balance updates correctly.
- A user cannot withdraw more than their balance.
- After withdrawal, the balance updates correctly.
- The contract total balance reflects deposits.

**Bonus:** Test multiple users depositing and withdrawing.

---

### 3. Local Blockchain

Start a local blockchain using `anvil`.

---

### 4. Deployment (inside `script/`)

- Write a deployment script in the `script/` folder.
- Deploy the contract locally.
- Confirm deployment was successful.

**Bonus Challenge:** Add one of the following:

- A minimum deposit requirement.
- A withdrawal cooldown (e.g., users can only withdraw once every 1 minute).
- Owner-only emergency withdraw function.

---

## Project Structure

```text
savings-bank/
├── src/
│   └── SavingsBank.sol          # Main smart contract
├── test/
│   └── SavingsBank.t.sol        # Unit tests
├── script/
│   └── DeploySavingsBank.s.sol  # Deployment script
└── README.md
```

## Setup & Usage

### 1. Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
# SavingsBank - Setup & Usage

## 2. Build & Test Contract
forge build
forge test -vv

✅ Tests verify:
- Deposits work
- Withdrawals work
- Over-withdrawal prevented
- Balance updates correctly
- Multiple users
- Total balance tracked

## 3. Start Local Blockchain
anvil

- Displays private keys and RPC URL: http://127.0.0.1:8545
- Keep it running during deployment and testing.

## 4. Deploy Contract Locally
forge script script/DeploySavingsBank.s.sol --rpc-url http://127.0.0.1:8545 --private-key <YOUR_ANVIL_KEY> --broadcast

- Copy the Contract Address from the output.
- Example: 0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35

## 5. Example Usage (Live Interaction)

Deposit ETH:
cast send <CONTRACT_ADDRESS> "deposit()" --value 1ether --private-key <YOUR_ANVIL_KEY> --rpc-url http://127.0.0.1:8545

Withdraw ETH:
cast send <CONTRACT_ADDRESS> "withdraw(uint256)" 0.5ether --private-key <YOUR_ANVIL_KEY> --rpc-url http://127.0.0.1:8545

Check User Balance:
cast call <CONTRACT_ADDRESS> "getBalance(address)" <USER_ADDRESS> --rpc-url http://127.0.0.1:8545

Check Contract Total Balance:
cast call <CONTRACT_ADDRESS> "totalBalance()" --rpc-url http://127.0.0.1:8545

## 6. Screenshots (Add Your Own)
Test Results:
*Add your screenshots here.*

Deployment Successful:
*Add your deployment screenshot here.*

## 7. Git & GitHub
Initialize Git:
git init
git add .
git commit -m "Initial commit - SavingsBank smart contract"

Create GitHub Repo:
- Go to GitHub → New repository
- Name: savings-bank
- Public → Do NOT initialize with README
- Click Create repository

Link Local Repo & Push:
git remote add origin https://github.com/<YourUsername>/savings-bank.git
git branch -M main
git push -u origin main

## 8. Bonus Features
Minimum deposit requirement:
require(msg.value >= 0.01 ether, "Min deposit 0.01 ETH");

Withdrawal cooldown (1 minute): tracks last withdrawal per user

Owner-only emergency withdraw function:
require(msg.sender == owner, "Only owner");

## Author
Your Name – GDG AASTU Web3
```
