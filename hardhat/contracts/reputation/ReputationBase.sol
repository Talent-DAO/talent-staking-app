pragma solidity ^0.8.15;
//SPDX-License-Identifier: GPL

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// todo: use the ERC1155Holder from openzeppelin
// import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";

import "../libs/Counters.sol";

error WrongRole();

abstract contract ReputationBase is AccessControl, Ownable {
    using Counters for Counters.Counter;
    using SafeERC20 for IERC20;

    // Roles
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");
    bytes32 public constant DAO_ROLE = keccak256("DAO_ROLE");

    modifier isPermittedDao() {
        if (!hasRole(DAO_ROLE, msg.sender)) revert WrongRole();
        _;
    }

    modifier isPermittedOperator() {
        if (!hasRole(OPERATOR_ROLE, msg.sender)) revert WrongRole();
        _;
    }

    modifier isAdminOrOwner() {
        if (!hasRole(DEFAULT_ADMIN_ROLE, msg.sender) || owner() == msg.sender)
            revert WrongRole();
        _;
    }

    // state variables
    Counters.Counter public userIds;
    mapping(uint => User) public users;
    mapping(uint => Metadata) public metadataPointers;

    // custom errors
    error BadUserId();
    error ZeroAddress();

    // structs
    struct User {
        uint256 totalScore;
        address userAddress;
        Reputation[] reputations;
    }

    struct Reputation {
        uint256 id;
        uint256 score;
        Metadata metadata;
    }

    struct Metadata {
        string pointer;
    }

    // events
    event NewUser(address indexed user);
    event ReputationIncreased(address indexed user, uint256 increaseAmt);
    event ReputationDecreased(address indexed user, uint256 decreaseAmt);
    event Blacklisted(address indexed user);

    function setupNewAdminRole(address _newAdmin, address _oldAdmin)
        public
        isAdminOrOwner
    {
        _setupRole(DEFAULT_ADMIN_ROLE, _newAdmin);
        _revokeRole(DEFAULT_ADMIN_ROLE, _oldAdmin);
    }

    function setupNewOperatorRole(address newOperator, address oldOperator)
        public
        isAdminOrOwner
    {
        if (!hasRole(DEFAULT_ADMIN_ROLE, _msgSender())) revert WrongRole();
        _setupRole(OPERATOR_ROLE, newOperator);
        _revokeRole(OPERATOR_ROLE, oldOperator);
    }

    function setupNewDaoRole(address newDao, address oldDao)
        public
        isAdminOrOwner
    {
        _setupRole(DAO_ROLE, newDao);
        _revokeRole(DAO_ROLE, oldDao);
    }

    function getUserId(address userAddress) public view returns (uint256) {
        for (uint256 i = 0; i < userIds.current(); i++) {
            if (users[i].userAddress == userAddress) {
                return i;
            }
        }
        revert BadUserId();
    }

    function _createNewUser(address userAddress) public returns (uint) {
        Counters.increment(userIds);
        User storage user = users[Counters.current(userIds)];

        user.totalScore = 0;
        user.userAddress = userAddress;

        emit NewUser(userAddress);

        return user.totalScore;
    }

    function increaseReputation(address userAddress, uint256 increaseAmt)
        public
    {
        User storage user = users[getUserId(userAddress)];
        user.totalScore += increaseAmt;

        emit ReputationIncreased(userAddress, increaseAmt);
    }

    function decreaseReputation(address userAddress, uint256 decreaseAmt)
        public
    {
        User storage user = users[getUserId(userAddress)];
        user.totalScore -= decreaseAmt;

        emit ReputationDecreased(userAddress, decreaseAmt);
    }

    function getReputationScore(address userAddress)
        public
        view
        returns (uint256)
    {
        User storage user = users[getUserId(userAddress)];
        return user.totalScore;
    }

    function blacklistUser(address userAddress) public onlyOwner {
        User storage user = users[getUserId(userAddress)];
        user.totalScore = 0;

        emit Blacklisted(userAddress);
    }

    function addReputationProtocol(string memory pointer) public onlyOwner {
        // todo: add reputation protocol properties
    }

    function removeReputationProtocol(string memory pointer) public onlyOwner {
        // todo: remove reputation protocol properties
    }
}
