// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/StakingPool.sol";

contract StakingPoolTest is Test {
    StakingPool staking;
    address user = address(1);

    uint256 rewardRate = 1 ether;

    function setUp() public {
        staking = new StakingPool(rewardRate);

        vm.deal(user, 10 ether);
    }

    /* ===================== STAKE ===================== */

    function testStake() public {
        vm.prank(user);

        staking.stake{value: 1 ether}();

        (uint256 amount, uint256 startTime, bool claimed) = staking.stakes(
            user
        );

        assertEq(amount, 1 ether);
        assertEq(claimed, false);
        assertGt(startTime, 0);
    }

    function testCannotStakeTwice() public {
        vm.startPrank(user);

        staking.stake{value: 1 ether}();

        vm.expectRevert("Already staking");
        staking.stake{value: 1 ether}();

        vm.stopPrank();
    }

    function testStakeRevertIfZero() public {
        vm.prank(user);

        vm.expectRevert("Stake amount must be greater than 0");
        staking.stake{value: 0}();
    }

    /* ===================== REWARD ===================== */

    function testCalculateReward() public {
        vm.prank(user);

        staking.stake{value: 1 ether}();

        vm.warp(block.timestamp + 10);

        uint256 reward = staking.calculateReward(user);

        assertEq(reward, 10 ether);
    }

    /* ===================== UNSTAKE ===================== */

    function testUnstake() public {
        vm.startPrank(user);

        staking.stake{value: 1 ether}();

        vm.warp(block.timestamp + 5);

        // ✅ fund contract BEFORE unstake
        vm.deal(address(staking), 100 ether);

        uint256 balanceBefore = user.balance;

        staking.unstake();

        uint256 balanceAfter = user.balance;

        assertGt(balanceAfter, balanceBefore);

        vm.stopPrank();
    }

    function testCannotUnstakeTwice() public {
        vm.startPrank(user);

        staking.stake{value: 1 ether}();

        vm.warp(block.timestamp + 5);

        // ✅ fund contract
        vm.deal(address(staking), 100 ether);

        staking.unstake();

        vm.expectRevert("Stake already claimed");
        staking.unstake();

        vm.stopPrank();
    }

    function testUnstakeWithoutStake() public {
        vm.prank(user);

        vm.expectRevert("No stake found");
        staking.unstake();
    }
}
