// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Test} from "forge-std/Test.sol";
import {PersonalCounter} from "../src/PersonalCounter.sol";

contract PersonalCounterTest is Test {
    PersonalCounter counter;

    address alice = address(1);
    address bob = address(2);

    function setUp() public {
        counter = new PersonalCounter();
    }

    function testIncrementWorks() public {
        vm.prank(alice);
        counter.increment();

        vm.prank(alice);
        assertEq(counter.getMyCounter(), 1);
    }

    function testResetWorks() public {
        vm.startPrank(alice);
        counter.increment();
        counter.reset();
        assertEq(counter.getMyCounter(), 0);
        vm.stopPrank();
    }

    function testCannotResetAnotherUserCounter() public {
        vm.prank(alice);
        counter.increment();

        vm.prank(bob);
        vm.expectRevert();
        counter.reset();
    }
}
