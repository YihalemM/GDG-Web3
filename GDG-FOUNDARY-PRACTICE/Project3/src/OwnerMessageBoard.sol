//SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract OwnerMessageBoard {
    address public owner;
    string public message;

    event MessageUpdated(string newMessage);

    constructor(string memory _initialMessage) {
        owner = msg.sender;
        message = _initialMessage;
    }

    function updateMessage(string memory _newMessage) public {
        require(msg.sender == owner, "Not owner");
        message = _newMessage;
        emit MessageUpdated(_newMessage);
    }
}
