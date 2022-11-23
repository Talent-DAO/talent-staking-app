pragma solidity ^0.8.15;
pragma experimental ABIEncoderV2;
//SPDX-License-Identifier: GPL

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

error WrongRole();
error LowBalance();
error PastDeadline();
error ZeroAddress();
error OnlyOwner();

/// @title The TALENT token is the token of the Talent DAO
/// @author jaxcoder
/// @custom:security-contact jaxcoder75@gmail.com
/// @dev Contract is pretty straightforward ERC20 token contract.
contract TalentToken is Ownable, AccessControl, ERC20 {
    using SafeERC20 for IERC20;

    mapping(address => uint96) internal _balances;
    mapping(address => mapping(address => uint256)) public allowances;

    // Roles
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant DAO_ROLE = keccak256("DAO_ROLE");
    bytes32 public constant DISTRIBUTOR_ROLE = keccak256("DISTRIBUTOR_ROLE");

    /// @notice Modifiers for Access Control
    modifier isPermittedMinter() {
        if(!hasRole(MINTER_ROLE, msg.sender)) revert WrongRole();
        _;
    }

    modifier isPermittedDao() {
        if(!hasRole(DAO_ROLE, msg.sender)) revert WrongRole();
        _;
    }

    modifier isPermittedOperator() {
        if(!hasRole(OPERATOR_ROLE, msg.sender)) revert WrongRole();
        _;
    }

    modifier isPermittedDistributor() {
        if(!hasRole(DISTRIBUTOR_ROLE, msg.sender)) revert WrongRole();
        _;
    }
    
    modifier isAdminOrOwner() {
        if(!hasRole(DEFAULT_ADMIN_ROLE, msg.sender) || owner() == msg.sender) revert WrongRole();
        _;
    }

    constructor(address owner_)
        ERC20("Talent DAO Token", "TALENT")
    {
        _setupRole(DEFAULT_ADMIN_ROLE, owner_);
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(MINTER_ROLE, _msgSender());
        // Mint some tokens... test....
        mintTokens(owner_, 200000000 ether);
        _revokeRole(MINTER_ROLE, _msgSender());
        transferOwnership(owner_);
    }

    function setupNewAdminRole(address _newAdmin, address _oldAdmin)
        public
        isAdminOrOwner
    {
        _setupRole(DEFAULT_ADMIN_ROLE, _newAdmin);
        _revokeRole(DEFAULT_ADMIN_ROLE, _oldAdmin);
    }

    /** @dev only the default admin role can add a minter
    *
    */
    function setupMinterRole(address minter)
        public
        isAdminOrOwner
    {
        if(!hasRole(DEFAULT_ADMIN_ROLE, _msgSender())) revert WrongRole();
        _setupRole(MINTER_ROLE, minter);
    }

    /** @dev only the default admin role can add an operator
    *
    */
    function setupOperatorRole(address operator)
        public
        isAdminOrOwner
    {
        if(!hasRole(DEFAULT_ADMIN_ROLE, _msgSender())) revert WrongRole();
        _setupRole(OPERATOR_ROLE, operator);
    }

    /** @dev only the owner can add a DAO role
    *
    */
    function setupDaoRole(address dao)
        public
        isAdminOrOwner
    {
        _setupRole(DAO_ROLE, dao);
    }

    /** @dev the operator and the admin roles can add a distributor
    *
    */
    function setupDistributorRole(address distributor)
        public
        isAdminOrOwner
    {
        if(hasRole(OPERATOR_ROLE, _msgSender()) || hasRole(DEFAULT_ADMIN_ROLE, _msgSender())) revert WrongRole();
        _setupRole(DISTRIBUTOR_ROLE, distributor);
    }

    /** @notice Creates `_amount` token to `_to`. Must only be called by permitted minter.
    *   @param _to who the tokens are minted to
    *   @param _amount the amount of tokens to mint
    */  
    function mintTokens(address _to, uint256 _amount)
        public
        isPermittedMinter
    {
        _mint(_to, _amount);
    }

    /// @notice Burn token from sender function
    /// @param _amount The amount to burn from sender
    function burn
    (
        uint256 _amount
    )
        public
        virtual
    {
        if (msg.sender == address(0)) revert ZeroAddress();
        _balances[msg.sender] -= uint96(_amount);

        _burn(msg.sender, _amount);
    }

    /// @notice Burns from a specified address
    /// @param _amount The amount to burn
    /// @param _from The from address to burn from
    function burnFrom
    (
        uint256 _amount,
        address _from
    )
        external
    {
        if (_from == address(0)) revert ZeroAddress();
        _balances[_from] -= uint96(_amount);

        _burn(_from, _amount);
    }

     /**
     * @dev See {ERC20-_beforeTokenTransfer}.
     *
     * Requirements: do we want to do anything before each transfer?
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        virtual
        override
    {
        super._beforeTokenTransfer(from, to, amount);

        
    }
}