// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract CollateralBackedTokenScript is Script {
    function setUp() public {
        string memory seedPhrase = vm.readFile(".secret");
        uint256 privateKey = vm.deriveKey(seedPhrase, 0);
        vm.startBroadcast(privateKey);
        vm.stopBroadcast();
    }

    function run() public {
        vm.broadcast();
    }
}
