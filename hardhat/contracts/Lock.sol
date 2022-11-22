// SPDX-License-Identifier: GPL
pragma solidity ^0.8.15;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Lock is Ownable {
    using SafeERC20 for IERC20;

    IERC20 public token;

    uint public unlockTime;

    event Withdrawal(address indexed user, uint amount, uint when);

    constructor(uint _unlockTime, address _token) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        token = IERC20(_token);

        unlockTime = _unlockTime;
        _transferOwnership(payable(msg.sender));
    }

    function withdraw(address user) public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner(), "You aren't the owner");

        emit Withdrawal(user, address(this).balance, block.timestamp);

        address payable owner = payable(owner());

        owner.transfer(address(this).balance);
    }
}
