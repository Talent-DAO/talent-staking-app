pragma solidity ^0.8.15;

//SPDX-License-Identifier: GPL

/// @dev TDAO token interface
interface ITDAOToken {
    function setupMinterRole(address minter) external;

    function setupOperatorRole(address operator) external;

    function setupDaoRole(address dao) external;

    function setupDistributorRole(address distributor) external;

    function setupNewAdminRole(address _newAdmin, address _oldAdmin) external;

    function mintTokens(address _to, uint256 _amount) external;

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function burn(uint256 _amount) external;

    function burnFrom(uint256 _amount, address _from) external;

    function balanceOf(address account) external view returns (uint256);
}
