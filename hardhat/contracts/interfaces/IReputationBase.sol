pragma solidity ^0.8.15;

//SPDX-License-Identifier: GPL

interface IReputationBase {
    function createNewUser(address userAddress) external;
    function increaseReputation(address userAddress, uint256 increaseAmt) external;
    function decreaseReputation(address userAddress, uint256 decreaseAmt) external;
    function getRepuation(address userAddress) external view returns (uint256);
    function blacklistUser(address userAddress) external;
}
