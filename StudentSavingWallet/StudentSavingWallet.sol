// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentSavingWallet {
    // State variables
    mapping(address => uint256) private balances;
    mapping(address => Transaction[]) private userTransactions;
    mapping(address => uint256) private lastDepositTime;
    uint256 minDeposit = 0.01 ether; // minimum depoait
    uint256 public lockPeriod = 2 minutes; // withdrawal lock for testing

    // Transaction structure
    struct Transaction {
        address user; // Address of the user who made the transaction
        uint256 amount; // Amount of ETH deposited or withdrawn
        bool isDeposit; // true = Deposit, false = Withdrawal
        uint256 timestamp; // Time of the transaction
    }

    //Events
    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed user, uint256 amount, uint256 timestamp);

    // --------FUNCTIONS--------------------

    function deposit() public payable {
        require(
            msg.value >= minDeposit,
            "Deposit amount must be at least 0.01 ETH"
        );

        // Update user balance
        balances[msg.sender] += msg.value;
        // Update last timestamp of deposit for the user
        lastDepositTime[msg.sender] = block.timestamp;
        // Record deposit transaction
        userTransactions[msg.sender].push(
            Transaction(msg.sender, msg.value, true, block.timestamp)
        );

        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(uint256 amount) public {
        // ensure user has enough balance and funds are not locked
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(
            block.timestamp >= lastDepositTime[msg.sender] + lockPeriod,
            "Funds are locked. for 2 minutes after deposit"
        );

        // Deduct balance
        balances[msg.sender] -= amount;

        // Transfer ETH to user
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "ETH transfer failed");

        // Record withdrawal transaction
        userTransactions[msg.sender].push(
            Transaction(msg.sender, amount, false, block.timestamp)
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
        return userTransactions[msg.sender];
    }
}
