// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract CollateralBackedToken is ERC20 {
    IERC20 public collateral;
    uint public price = 1;

    constructor(address _collateral) ERC20("Collateral Backed Token", "CBT") {
        collateral = IERC20(_collateral);
    }

    // This is the deposits   function to  add your collateral

    function deposit(uint collateralAmount) external {
        collateral.transferFrom(msg.sender, address(this), collateralAmount);
        _mint(msg.sender, collateralAmount * price);
    }

    // This is the withdraw  function to  remove you funds and return you collateral
    function withdraw(uint withdrawAmount) external {
        require(balanceOf(msg.sender) >= withdrawAmount, "balance to low");
        _burn(msg.sender, withdrawAmount);
        collateral.transfer(msg.sender, withdrawAmount / price);
    }
}
