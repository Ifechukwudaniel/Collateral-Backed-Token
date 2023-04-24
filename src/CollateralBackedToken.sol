// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20";
import "openzeppelin-contracts/contracts/token/ERC20/utils/IERC20";

contract CollateralBackedToken is ERC20 {
    IERC20 public collateral 
    uint public price = 1;

    constructor(address _collateral) ERC20("Collateral Backed Token", "CBT") {
        collateral = IERC20(_collateral)
    }


   
    function deposit( uint collateralAmount)  external () {
        collateral.transferFrom(msg.sender, address(this), collateralAmount)
        _mint(msg.sender, collateralAmount*price)
    }

}


