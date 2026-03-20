//SPDX-License.Identfier:MIT
pragma solidity 0.8.20;

import "forge-std/Script.sol";
import "../src/StakingPool.sol";

contract DeployStakingPool is Script {
    function run() public {
vm.startBroadcast();

uint256 rewardRate = 1 ether; // 1 token per second
    // Deploy the contract
    StakingPool stakingPool = new StakingPool(rewardRate);

    console.log("StakingPool deployed at:", address(stakingPool));
    vm.stopBroadcast();
    
