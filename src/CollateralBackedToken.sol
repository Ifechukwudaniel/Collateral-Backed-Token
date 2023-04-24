// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract CollateralBackedToken is ERC20 {
    // We can  implement multiple token
    IERC20 public collateral;
    uint public price = 1;

    event Deposit(
        address indexed _from,
        uint collateralAmount,
        uint tokensAwarded
    );

    event Withdraw(
        address indexed _from,
        uint tokensBurned,
        uint collateralReturned
    );

    constructor(address _collateral) ERC20("Collateral Backed Token", "CBT") {
        collateral = IERC20(_collateral);
    }

    // This is the deposits function to  add your collateral

    function deposit(uint collateralAmount) external {
        collateral.transferFrom(msg.sender, address(this), collateralAmount);
        uint tokensAwarded = collateralAmount * price;
        _mint(msg.sender, tokensAwarded);
        emit Deposit(msg.sender, collateralAmount, tokensAwarded);
    }

    // This is the withdraw  function to  remove you funds and return you collateral
    function withdraw(uint withdrawAmount) external {
        require(balanceOf(msg.sender) >= withdrawAmount, "balance to low");
        _burn(msg.sender, withdrawAmount);
        uint collateralReturned = withdrawAmount / price;
        collateral.transfer(msg.sender, collateralReturned);
        emit Withdraw(msg.sender, withdrawAmount, collateralReturned);
    }
}
