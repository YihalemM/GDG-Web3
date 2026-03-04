//SPDX-License-Identfier:MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/ETHVault.sol";

contract ETHVaultTest is Test {
    ETHVault vault;
    address user = address(1);

    function setUp() public {
        vault = new ETHVault();
    }

    // test deposit function
    function testDepositUpdatesBalance() public {
        vm.deal(user, 1 ether);

        vm.prank(user);
        vault.deposit{value: 1 ether}();
        assertEq(vault.balances(user), 1 ether);
    }

    // test withdraw function
    function testwithdrawTransfersETH() public {
        vm.deal(user, 1 ether);

        vm.startPrank(user);
        vault.deposit{value: 1 ether}();
        vault.withdraw();
        vm.stopPrank();
        assertEq(vault.balances(user), 0);
        assertEq(user.balance, 1 ether);
    }

    // Test 3 : withdraw without balance reverts
    function testwithdrawwithoutBalanceReverts() public {
        vm.prank(user);
        vm.expectRevert();
        vault.withdraw();
    }
}
