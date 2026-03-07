// SPDX-license-Identifier:MIT
pragma solidity ^0.8.33;
import {Script} from "forge-std/Script.sol";
// Update the import to match the actual contract name in CrowdFund.sol
import {CrowdFund} from "../src/CrowdFund.sol";

contract DeployCrowdFunding is Script {
    function run() external returns (CrowdFund) {
        vm.startBroadcast();
        CrowdFund crowdFund = new CrowdFund();
        vm.stopBroadcast();
        return crowdFund;
    }
}
