// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract SavingsBank {
    mapping(address => uint256) private balances;
    mapping(address => uint256) private lastWithdrawTime;

    uint256 public constant WITHDRAW_COOLDOWN = 60; // seconds
    uint256 public constant MIN_DEPOSIT = 0.01 ether;

    address public owner;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    constructor() {
        owner = msg.sender; // set contract deployer as owner
    }

    // Deposit ETH
    function deposit() external payable {
        require(msg.value >= MIN_DEPOSIT, "Deposit too small");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw ETH with cooldown
    function withdraw(uint256 amount) external {
        require(amount <= balances[msg.sender], "Insufficient balance");
        require(
            block.timestamp >= lastWithdrawTime[msg.sender] + WITHDRAW_COOLDOWN,
            "Withdraw cooldown active"
        );

        balances[msg.sender] -= amount;
        lastWithdrawTime[msg.sender] = block.timestamp;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Transfer failed");
        emit Withdraw(msg.sender, amount);
    }

    // Emergency withdraw by owner
    function emergencyWithdraw() external {
        require(msg.sender == owner, "Only owner");

        uint256 total = address(this).balance;
        (bool sent, ) = owner.call{value: total}("");
        require(sent, "Transfer failed");
    }

    // Check balance of a user
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    // Total ETH in contract
    function getTotalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
