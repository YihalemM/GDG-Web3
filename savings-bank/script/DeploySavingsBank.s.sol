// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Script} from "forge-std/Script.sol";
import {SavingsBank} from "../src/SavingsBank.sol";

contract DeploySavingsBank is Script {
    function run() external {
        vm.startBroadcast();

        new SavingsBank();

        vm.stopBroadcast();
    }
}
