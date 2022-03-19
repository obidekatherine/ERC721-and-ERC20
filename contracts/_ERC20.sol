// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MetaCoin is ERC20 {

    uint256 private price = 1000;
    constructor() ERC20("MetaCoin", "MCN") {
        _mint(msg.sender, 1000000 * 10 ** 18);
    }


    function buyToken(address _reciever, uint256 _value) external payable returns (bool success) {
        require(msg.value >= _value*price);
        _transfer(msg.sender, _reciever, _value*price);
        return true;
    }

}
