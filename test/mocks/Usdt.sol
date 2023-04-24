// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Usdt is ERC20 {
    constructor(address _collateral) ERC20("Tether", "Usdt") {}
}
