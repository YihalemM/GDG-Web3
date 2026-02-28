// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract SavingsBank {
    mapping(address => uint256) private balances;
    mapping(address => uint256) private lastWithdrawTime;

    uint256 public totalDeposits;
    uint256 public constant MIN_DEPOSIT = 0.01 ether;
    uint256 public constant WITHDRAW_COOLDOWN = 1 minutes;

    address public owner;

    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);
    event EmergencyWithdraw(address indexed owner, uint256 amount);

    constructor() {
        owner = msg.sender; // Set contract deployer as owner
    }

    // Deposit ETH with minimum check
    function deposit() external payable {
        require(msg.value >= MIN_DEPOSIT, "Deposit too small");

        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw ETH with balance and cooldown check
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(
            block.timestamp - lastWithdrawTime[msg.sender] >= WITHDRAW_COOLDOWN,
            "Withdraw cooldown active"
        );

        balances[msg.sender] -= amount;
        totalDeposits -= amount;
        lastWithdrawTime[msg.sender] = block.timestamp;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdraw failed");

        emit Withdrawal(msg.sender, amount);
    }

    // Emergency withdraw by owner only
    function emergencyWithdraw() external {
        require(msg.sender == owner, "Only owner");

        uint256 contractBalance = address(this).balance;
        totalDeposits = 0;

        (bool success, ) = owner.call{value: contractBalance}("");
        require(success, "Emergency withdraw failed");

        emit EmergencyWithdraw(owner, contractBalance);
    }

    // Check balance of a user
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    // Check total ETH stored in contract
    function getTotalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
