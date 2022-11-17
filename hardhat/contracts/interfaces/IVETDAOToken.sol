pragma solidity ^0.8.15;

//SPDX-License-Identifier: GPL

/// @dev TDAO token interface
interface IVETDAOToken {
    // Role admin functions
    function setupNewAdminRole(address _oldAdmin, address _newAdmin) external;

    function setupMinterRole(address newMinter) external;

    function setupOperatorRole(address newOperator) external;

    function setupDaoRole(address _newDao) external;

    function setupDistributorRole(address _newDistributor) external;

    // Token functions
    function mintTokensTo(address _to, uint256 _amount) external;

    function burn(uint256 _amount) external;

    function burnFrom(address _from, uint256 _amount) external;

    function permit(
        address owner,
        address spender,
        uint rawAmount,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function balanceOf(address account) external view returns (uint256);

    function delegate(address delegatee) external;

    function delegatesView(address delegator) external view returns (address);

    function delegateBySig(
        address delegatee,
        uint nonce,
        uint expiry,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function getCurrentVotes(address account) external view returns (uint256);

    function getPriorVotes(address account, uint blockNumber)
        external
        view
        returns (uint256);
}
