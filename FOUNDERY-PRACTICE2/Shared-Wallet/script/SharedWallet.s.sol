// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/SharedWallet.sol";

contract DeploySharedWallet is Script {
    function run() external {
        // Start broadcasting transactions to network
        vm.startBroadcast();

        // Deploy SharedWallet contract
        SharedWallet wallet = new SharedWallet();

        // Log the deployed contract address
        console.log("SharedWallet deployed at:", address(wallet));

        vm.stopBroadcast();
    }
}
