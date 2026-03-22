# SharedWallet

A simple **Shared Wallet** smart contract built with Solidity and tested using **Foundry**.  
It allows users to deposit ETH and lets the owner withdraw funds safely.

---

## Features

- Users can **deposit ETH** into the wallet.
- Tracks **individual balances** and **total contract balance**.
- Maintains a **record of all deposits** with timestamp.
- **Owner-only withdrawals** with balance checks.
- Fully tested with Foundry for **reliability and safety**.

---

## Deployment

Use Foundry to deploy the contract:

```bash
forge script script/DeploySharedWallet.s.sol:DeploySharedWallet \
    --rpc-url <RPC_URL> \
    --private-key <PRIVATE_KEY> \
    --broadcast
```

Replace <RPC_URL> with your network endpoint and <PRIVATE_KEY> with your deployer key.

### Testing

**Run the full test suite using Foundry:**

forge test -vv

All tests cover:
Deposit logic (single/multiple, zero-ETH revert)
Owner-only withdrawal
Multi-user deposit tracking
Full withdrawal scenarios
Usage
SharedWallet wallet = SharedWallet(<deployed_address>);

// Deposit
wallet.deposit{value: 1 ether}();

// Owner withdraw
wallet.withdraw(0.5 ether);

### Tech Stack

Solidity ^0.8.20
Foundry (forge) for testing and deployment
License

MIT
