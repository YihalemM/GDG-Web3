// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SharedWallet.sol";

contract SharedWalletTest is Test {
    SharedWallet wallet;
    address owner;
    address user1 = address(1);
    address user2 = address(2);

    function setUp() public {
        owner = address(this); // test contract is owner
        wallet = new SharedWallet();

        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }

    // Allow the test contract to receive ETH
    receive() external payable {}

    /* ===================== DEPOSIT ===================== */

    function testDeposit() public {
        vm.prank(user1);
        wallet.deposit{value: 1 ether}();

        assertEq(wallet.balances(user1), 1 ether);
        assertEq(wallet.totalBalance(), 1 ether);
        assertEq(wallet.getDepositsCount(), 1);

        // Check deposit record
        (address u, uint256 amt, ) = wallet.deposits(0);
        assertEq(u, user1);
        assertEq(amt, 1 ether);
    }

    function testMultipleDeposits() public {
        vm.startPrank(user1);
        wallet.deposit{value: 1 ether}();
        wallet.deposit{value: 2 ether}();
        vm.stopPrank();

        assertEq(wallet.balances(user1), 3 ether);
        assertEq(wallet.totalBalance(), 3 ether);
        assertEq(wallet.getDepositsCount(), 2);
    }

    function testDepositRevertsIfZero() public {
        vm.prank(user1);
        vm.expectRevert("Must send ETH to Deposit");
        wallet.deposit{value: 0}();
    }

    /* ===================== WITHDRAW ===================== */

    function testOwnerCanWithdraw() public {
        // deposit some funds first
        vm.prank(user1);
        wallet.deposit{value: 5 ether}();

        uint256 ownerBalanceBefore = owner.balance;

        wallet.withdraw(3 ether);

        uint256 ownerBalanceAfter = owner.balance;

        assertEq(ownerBalanceAfter - ownerBalanceBefore, 3 ether);
        assertEq(wallet.totalBalance(), 2 ether);
    }

    function testWithdrawRevertsIfNotOwner() public {
        vm.prank(user1);
        vm.expectRevert("only owner can withdraw");
        wallet.withdraw(1 ether);
    }

    function testWithdrawRevertsIfInsufficientBalance() public {
        vm.expectRevert("Insufficient contract balance");
        wallet.withdraw(1 ether);
    }

    function testWithdrawAllFunds() public {
        vm.prank(user1);
        wallet.deposit{value: 4 ether}();

        uint256 ownerBalanceBefore = owner.balance;

        wallet.withdraw(4 ether);

        uint256 ownerBalanceAfter = owner.balance;

        assertEq(ownerBalanceAfter - ownerBalanceBefore, 4 ether);
        assertEq(wallet.totalBalance(), 0);
    }

    /* ===================== MULTIUSER ===================== */

    function testMultipleUsersDeposit() public {
        vm.prank(user1);
        wallet.deposit{value: 2 ether}();

        vm.prank(user2);
        wallet.deposit{value: 3 ether}();

        assertEq(wallet.balances(user1), 2 ether);
        assertEq(wallet.balances(user2), 3 ether);
        assertEq(wallet.totalBalance(), 5 ether);
        assertEq(wallet.getDepositsCount(), 2);
    }
}
