// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentSavingWallet {
    // Store user balances
    mapping(address => uint256) private balances;

    // Transaction structure
    struct Transaction {
        address user; // Address of the user who made the transaction
        uint256 amount; // Amount of ETH deposited or withdrawn
        bool isDeposit; // true = Deposit, false = Withdrawal
        uint256 timestamp; // Time of the transaction
    }

    // Array to store all transactions
    Transaction[] private transactions;
    //Events
    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed user, uint256 amount, uint256 timestamp);

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");

        // Add ETH to user's balance
        balances[msg.sender] += msg.value;

        // Record deposit transaction
        transactions.push(
            Transaction({
                user: msg.sender,
                amount: msg.value,
                isDeposit: true,
                timestamp: block.timestamp
            })
        );
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Subtract from balance
        balances[msg.sender] -= amount;

        // Transfer ETH to user
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "ETH transfer failed");

        // Record withdrawal transaction
        transactions.push(
            Transaction({
                user: msg.sender,
                amount: amount,
                isDeposit: false,
                timestamp: block.timestamp
            })
        );
        emit Withdrawal(msg.sender, amount, block.timestamp);
    }

    // Check wallet balance
    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Get transaction history
    function getTransactionHistory()
        public
        view
        returns (Transaction[] memory)
    {
        return transactions;
    }
}
