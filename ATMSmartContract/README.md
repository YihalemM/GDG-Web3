# ATM Smart Contract - GDG Week 4 Task

A Solidity smart contract simulating an **ATM** system.  
Users can **deposit ETH**, **withdraw ETH**, **check their balance**, and the **owner can pause/unpause** the contract.

---

## Features

- Deposit and withdraw ETH
- Check your account balance
- Owner-controlled pause/unpause of the contract
- Fully decentralized on Ethereum (Sepolia testnet)

---

## Functions

### User Functions

- `deposit()`  
  Deposit ETH into your account. Must send a positive amount.

- `withdraw(uint256 amount)`  
  Withdraw ETH from your account. Requires sufficient balance.

- `checkBalance()`  
  Check your account balance. Returns the amount of ETH stored for the caller.

### Owner Functions

- `pause()`  
  Pause contract operations. Only callable by the owner.

- `unpause()`  
  Resume contract operations. Only callable by the owner.

---

## Deployment & Usage

1. Open [Remix IDE](https://remix.ethereum.org).
2. Create a new file `ATM.sol` and paste the smart contract code.
3. Set **Solidity compiler** version `^0.8.20`.
4. Compile the contract.
5. Deploy on **Sepolia testnet** using MetaMask.
6. Interact with the contract using the functions:
   - `deposit()` → Send ETH to deposit
   - `withdraw(amount)` → Withdraw ETH
   - `checkBalance()` → View your balance
   - `pause()` / `unpause()` → Owner controls pause status
7. All transactions are recorded on-chain and can be viewed in **Sepolia Etherscan**.

---

## Notes

- Only the **owner** can pause or unpause the contract.
- Users maintain full control of their deposited ETH.
- Contract prevents withdrawals if the balance is insufficient.
