// SPDX-License-Identifier:MIT
pragma solidity ^0.8.33;

import {Test} from "forge-std/Test.sol";
import {CrowdFund} from "../src/CrowdFund.sol";

contract CrowdFundTest is Test {
    CrowdFund crowdfund;

    receive() external payable {}

    function setUp() public {
        crowdfund = new CrowdFund();
    }

    // Test -Creat Campaign
    function testCreateCampaign() public {
        crowdfund.create(1 ether, 7 days);

        (
            address owner,
            uint256 goal,
            uint256 pledged,
            uint256 startAt,
            uint256 endAt,
            bool claimed
        ) = crowdfund.campaigns(1);

        assertEq(owner, address(this));
        assertEq(goal, 1 ether);
        assertEq(pledged, 0);
        assertEq(claimed, false);

        // Use startAt and endAt to avoid unused variable warning
        assertGt(startAt, 0);
        assertGt(endAt, 0);
    }

    // tests for pledge

    function testPledge() public {
        crowdfund.create(1 ether, 7 days);

        address alice = address(1);
        // give alice ETH
        vm.deal(alice, 5 ether);
        // simulate alice calling pledge
        vm.prank(alice);
        crowdfund.pledge{value: 1 ether}(1);
        uint256 pledged = crowdfund.pledgedAmount(1, alice);
        assertEq(pledged, 1 ether);
    }

    function testclaimsuccess() public {
        crowdfund.create(1 ether, 7 days);
        address alice = address(1);
        // give alice ETH
        vm.deal(alice, 5 ether);

        // alice pledges
        vm.prank(alice);
        crowdfund.pledge{value: 1 ether}(1);
        // move time forward(campaign ends)
        vm.warp(block.timestamp + 7 days + 1);

        // owner balance before claims
        uint256 ownerBalanceBefore = address(this).balance;

        // owner claims funds
        crowdfund.claim(1);
        // owner balance after claims
        uint256 ownerBalanceAfter = address(this).balance;

        // Assert that the owner's balance increased by 1 ether after claiming
        assertEq(ownerBalanceAfter, ownerBalanceBefore + 1 ether);

        // assert that campign is marked  as claimed
        (, , , , , bool claimed) = crowdfund.campaigns(1);
        assertEq(claimed, true);
    }

    // Removed duplicate refund function; use crowdfund.refund in tests instead.

    function testRefundBeforeEndFails() public {
        crowdfund.create(5 ether, 7 days);
        address alice = address(1);
        vm.deal(alice, 1 ether);
        vm.prank(alice);
        crowdfund.pledge{value: 1 ether}(1);

        // Refund called BEFORE campaign ends should revert
        vm.prank(alice);
        vm.expectRevert(bytes("Campaign has not ended")); // match exact message
        crowdfund.refund(1);
    }
}
