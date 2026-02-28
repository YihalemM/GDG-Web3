// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Test} from "forge-std/Test.sol";
import {SavingsBank} from "../src/SavingsBank.sol";

contract SavingsBankTest is Test {
    SavingsBank bank;

    address user1 = address(1);
    address user2 = address(2);
    address owner;

    // Make the test contract payable so it can receive ETH during emergency withdraw
    receive() external payable {}

    function setUp() public {
        bank = new SavingsBank();
        owner = address(this); // test contract deployer is owner

        // Give users 10 ETH each
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }

    // --- Deposit Tests ---
    function testDeposit() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        assertEq(bank.getBalance(user1), 1 ether);
    }

    function testDepositFailsBelowMinimum() public {
        vm.prank(user1);
        vm.expectRevert("Deposit too small");
        bank.deposit{value: 0.001 ether}();
    }

    // --- Withdraw Tests ---
    function testCannotWithdrawMoreThanBalance() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        vm.prank(user1);
        vm.expectRevert("Insufficient balance");
        bank.withdraw(2 ether);
    }

    function testWithdraw() public {
        vm.prank(user1);
        bank.deposit{value: 2 ether}();

        // warp to bypass cooldown
        vm.warp(block.timestamp + 61);

        vm.prank(user1);
        bank.withdraw(1 ether);

        assertEq(bank.getBalance(user1), 1 ether);
    }

    function testWithdrawCooldown() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();

        // first withdraw after cooldown
        vm.warp(block.timestamp + 61);
        vm.prank(user1);
        bank.withdraw(0.5 ether);

        // immediate withdraw should fail
        vm.prank(user1);
        vm.expectRevert("Withdraw cooldown active");
        bank.withdraw(0.1 ether);

        // warp another 61 seconds and withdraw
        vm.warp(block.timestamp + 61);
        vm.prank(user1);
        bank.withdraw(0.1 ether);

        assertEq(bank.getBalance(user1), 0.4 ether);
    }

    // --- Total Balance & Multiple Users ---
    function testTotalBalance() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        vm.prank(user2);
        bank.deposit{value: 2 ether}();
        assertEq(bank.getTotalBalance(), 3 ether);
    }

    function testMultipleUsers() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        vm.prank(user2);
        bank.deposit{value: 2 ether}();

        // warp to allow withdrawals
        vm.warp(block.timestamp + 61);

        vm.prank(user1);
        bank.withdraw(0.5 ether);

        assertEq(bank.getBalance(user1), 0.5 ether);
        assertEq(bank.getBalance(user2), 2 ether);
    }

    // --- Emergency Withdraw ---
    function testEmergencyWithdrawByOwner() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        vm.prank(user2);
        bank.deposit{value: 2 ether}();

        // owner calls emergency withdraw
        vm.prank(owner);
        bank.emergencyWithdraw();

        // Contract balance should now be 0
        assertEq(bank.getTotalBalance(), 0);
    }

    function testEmergencyWithdrawFailsForNonOwner() public {
        vm.prank(user1);
        bank.deposit{value: 1 ether}();
        vm.prank(user1);
        vm.expectRevert("Only owner");
        bank.emergencyWithdraw();
    }
}
