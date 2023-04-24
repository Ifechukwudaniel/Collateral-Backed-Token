// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "./mocks/Usdt.sol";
import "../src/CollateralBackedToken.sol";

contract CollateralBackedTokenTest is Test {
    Usdt public collateral;
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

    function testCanGetCollateral() public {
        collateral.faucet(user1, 1 ether);
        collateral.faucet(user2, 0.5 ether);
        assertEq(collateral.balanceOf(user1), 1 ether);
        assertEq(collateral.balanceOf(user2), 0.5 ether);
    }

    function testCanDepositCollateral() public {
        collateral.faucet(user1, 1 ether);
        vm.startPrank(user1);
        collateral.approve(address(collateralToken), 1 ether);
        collateralToken.deposit(1 ether);
        vm.stopPrank();
        assertEq(collateralToken.balanceOf(user1), 1 ether);
    }

    function testCanWithdrawCollateral() public {
        vm.startPrank(user1);
        collateral.faucet(user1, 1 ether);
        assertEq(collateral.balanceOf(user1), 1 ether);
        collateral.approve(address(collateralToken), 1 ether);
        collateralToken.deposit(1 ether);
        assertEq(collateral.balanceOf(user1), 0);
        assertEq(collateralToken.balanceOf(user1), 1 ether);
        collateralToken.withdraw(1 ether);
        assertEq(collateralToken.balanceOf(user1), 0);
        assertEq(collateral.balanceOf(user1), 1 ether);
        vm.stopPrank();
    }

    function testCantWithdrawCollateralLowBalance() public {
        vm.startPrank(user1);
        collateral.faucet(user1, 1 ether);
        collateral.approve(address(collateralToken), 1 ether);
        collateralToken.deposit(1 ether);
        collateralToken.withdraw(10 ether);
        vm.stopPrank();
        vm.expectRevert(abi.encodeWithSignature("LOW_BALANCE"));
    }
}
