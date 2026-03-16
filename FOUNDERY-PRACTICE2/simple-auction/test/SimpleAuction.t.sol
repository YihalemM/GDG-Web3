//SPDX-License-Identifier:MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {SimpleAuction} from "../src/SimpleAuction.sol";

contract SimpleAuctionTest is Test {
    SimpleAuction public auction;
    address seller = address(1);
    address bidder1 = address(2);
    address bidder2 = address(3);

    function setUp() public {
        vm.deal(seller, 10 ether);
        vm.deal(bidder1, 10 ether);
        vm.deal(bidder2, 10 ether);
        vm.prank(seller);
        auction = new SimpleAuction();
    }

    function testCreateAuction() public {
        vm.prank(seller);
        auction.creatAuction(1 days);

        (address s, , uint256 bid, , ) = auction.auctions(1);

        assertEq(s, seller);
        assertEq(bid, 0);
    }

    function testBidding() public {
        vm.prank(seller);
        auction.creatAuction(1 days);

        vm.prank(bidder1);
        auction.bid{value: 1 ether}(1);

        vm.prank(bidder2);
        auction.bid{value: 2 ether}(1);

        (, address highestBidder, uint256 highestBid, , ) = auction.auctions(1);

        assertEq(highestBidder, bidder2);
        assertEq(highestBid, 2 ether);
    }

    function testWithdraw() public {
        vm.prank(seller);
        auction.creatAuction(1 days);

        vm.prank(bidder1);
        auction.bid{value: 1 ether}(1);

        vm.prank(bidder2);
        auction.bid{value: 2 ether}(1);

        vm.prank(bidder1);
        auction.withdraw();
    }

    function testEndAuction() public {
        vm.prank(seller);
        auction.creatAuction(1 days);

        vm.prank(bidder1);
        auction.bid{value: 1 ether}(1);

        vm.warp(block.timestamp + 2 days);

        auction.endAuction(1);

        (, , , , bool ended) = auction.auctions(1);
        assertEq(ended, true);
    }
}
