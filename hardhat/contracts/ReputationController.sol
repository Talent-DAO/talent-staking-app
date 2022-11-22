pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: GPL

import {ReputationBase} from "./reputation/ReputationBase.sol";

contract ReputationController is ReputationBase {
    constructor(address _owner) {}

    function createNewUser(address _userAddress)
        public
        returns (uint totalScore)
    {
        totalScore = _createNewUser(_userAddress);
    }
}
