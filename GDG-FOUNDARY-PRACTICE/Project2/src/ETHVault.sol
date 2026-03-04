// SPDX-License-Identifier:MIT
pragma solidity ^0.8.33;

contract ETHVault {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "must send ETH");
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balances to withdraw");

        //EFFECTS (update state first)
        balances[msg.sender] = 0;
        // INTRACTION(send ETH after state chanege)
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "failed to send ETH");
    }
}
