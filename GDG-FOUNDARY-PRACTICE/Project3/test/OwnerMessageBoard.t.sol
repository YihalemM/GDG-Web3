// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Test.sol";
import "../src/OwnerMessageBoard.sol";

contract OwnerMessageBoardTest is Test {
    OwnerMessageBoard board;

    address owner = address(1);
    address user = address(2);

    function setUp() public {
        vm.prank(owner);
        board = new OwnerMessageBoard("Hello");
    }

    function testOwnerCanUpdate() public {
        vm.prank(owner);
        board.updateMessage("New Message");

        assertEq(board.message(), "New Message");
    }

    function testNonOwnerCannotUpdate() public {
        vm.prank(user);

        vm.expectRevert("Not owner");
        board.updateMessage("Hack");
    }

    function testEventEmitted() public {
        vm.prank(owner);

        vm.expectEmit(true, false, false, true);
        emit OwnerMessageBoard.MessageUpdated("Updated");

        board.updateMessage("Updated");
    }
}
