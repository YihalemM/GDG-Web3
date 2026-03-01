// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract PersonalCounter {
    mapping(address => uint256) private counters;

    function increment() public {
        counters[msg.sender] += 1;
    }

    function reset() public {
        require(counters[msg.sender] > 0, "Counter already zero");
        counters[msg.sender] = 0;
    }

    function getMyCounter() public view returns (uint256) {
        return counters[msg.sender];
    }
}
