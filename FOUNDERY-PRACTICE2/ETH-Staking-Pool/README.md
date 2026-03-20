# 🪙 ETH Staking Pool

A **production-ready Ethereum staking contract** with rewards per second, safe ETH transfers, and reentrancy protection. Includes full Foundry tests and a deployment script.

---

## Features

- Stake ETH and earn rewards per second
- Safe ETH transfer using `call`
- ReentrancyGuard protection
- Events: `Staked` & `Unstaked`
- Full test suite (staking, rewards, unstake, attack simulation)
- Deployment script for local or test networks

---

## Usage

### 1️⃣ Deploy

```text
forge script script/DeployStakingPool.s.sol:DeployStakingPool \
    --rpc-url $RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast
```

    2️⃣ Fund Contract (optional)

The contract can receive ETH:

```text
receive() external payable {}
```

3️⃣ Stake ETH

```text
stakingPool.stake{value: 1 ether}();
```

4️⃣ Calculate Rewards

```text
stakingPool.calculateReward(user);
```

5️⃣ Unstake ETH + Rewards

```text
stakingPool.unstake();
```

Testing

Run all Foundry tests:

```text
forge test -vv
```

Tests include:

```text
Stake & unstake flows

Reward calculation

Reverts for invalid actions

Reentrancy attack simulation

```

Requirements

```text

Solidity ^0.8.20

Foundry (forge & cast)

Optional: Sepolia or local Anvil RPC

```

License

MIT License

```

```
