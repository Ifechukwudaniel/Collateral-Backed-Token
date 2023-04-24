// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "./mocks/Usdt.sol";
import "../src/CollateralBackedToken.sol";

contract CollateralBackedTokenTest is Test {
    IERC20 public collateral;
    uint public price;
    CollateralBackedToken public collateralToken;
    address user1;
    address user2;

    function setUp() public {
        collateral = new Usdt();
        collateralToken = new CollateralBackedToken(address(collateral));
        user1 = vm.addr(1);
        user2 = vm.addr(2);
    }

    function canMint() public {
        console.log(user1);
        console.log(user2);
        uint values = 10;
        assertEq(values, 10);
        // collateral.faucet()
    }
}
