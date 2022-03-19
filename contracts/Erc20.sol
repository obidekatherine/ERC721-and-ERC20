// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract MyToken is ERC20 {
    address Owner;
    constructor()
    ERC20("MyToken", "MTO"){
        Owner = msg.sender;
        _mint(Owner,1000000 * 10**18());

    }
}