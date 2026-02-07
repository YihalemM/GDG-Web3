// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentSavingWallet {
    // ---------- STATE VARIABLES ----------
    mapping(address => uint256) private balances;
    mapping(address => Transaction[]) private userTransactions;
    mapping(address => uint256) private lastDepositTime;

    uint256 public minDeposit = 0.01 ether;
    uint256 public lockPeriod = 2 minutes;

    address private owner;
    bool public paused = false;

    // ---------- STRUCT ----------
    struct Transaction {
        address user;
        uint256 amount;
        bool isDeposit;
        uint256 timestamp;
    }

    // ---------- EVENTS ----------
    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed user, uint256 amount, uint256 timestamp);
    event Paused(bool paused);
    event EmergencyWithdrawal(address owner, uint256 amount);

    // ---------- MODIFIERS ----------
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier notPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    // ---------- CONSTRUCTOR ----------
    constructor() {
        owner = msg.sender; // Deployer becomes the owner
    }

    // ---------- FUNCTIONS ----------

    function deposit() public payable notPaused {
        require(msg.value >= minDeposit, "Deposit must be at least 0.01 ETH");
        balances[msg.sender] += msg.value;
        lastDepositTime[msg.sender] = block.timestamp;

        userTransactions[msg.sender].push(
            Transaction(msg.sender, msg.value, true, block.timestamp)
        );

        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(uint256 amount) public notPaused {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(
            block.timestamp >= lastDepositTime[msg.sender] + lockPeriod,
            "Funds are locked for 2 minutes"
        );

        balances[msg.sender] -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "ETH transfer failed");

        userTransactions[msg.sender].push(
            Transaction(msg.sender, amount, false, block.timestamp)
        );

        emit Withdrawal(msg.sender, amount, block.timestamp);
    }

    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function getTransactionHistory()
        public
        view
        returns (Transaction[] memory)
    {
        return userTransactions[msg.sender];
    }

    // ---------- OWNER/ADMIN FUNCTIONS ----------

    function setPaused(bool _paused) public onlyOwner {
        paused = _paused;
        emit Paused(paused);
    }

    function emergencyWithdrawal() public onlyOwner {
        uint256 contractBalance = address(this).balance;
        (bool success, ) = payable(owner).call{value: contractBalance}("");
        require(success, "Emergency withdrawal failed");

        emit EmergencyWithdrawal(owner, contractBalance);
    }
}
