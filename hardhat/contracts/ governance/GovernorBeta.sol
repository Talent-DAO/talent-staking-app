pragma solidity ^0.0.15;
//SPDX-License-Identifier: GPL

import "hardhat/console.sol"; // Remove after testing is completed - JR
import "@openzeppelin/contracts/access/Ownable.sol";
/**
 * @dev Core of the governance system, designed to be extended though various modules.
 *
 * This contract is abstract and requires several function to be implemented in various modules:
 *
 * - A counting module must implement {quorum}, {_quorumReached}, {_voteSucceeded} and {_countVote}
 * - A voting module must implement {_getVotes}
 * - Additionanly, the {votingPeriod} must also be implemented
 *
 */
// import "@openzeppelin/contracts/governance/Governor.sol";

/// @title Governor Beta contract for governance and propsals
/// @author jaxcoder
/// @notice handles proposals
contract GovernorBeta is Ownable {
    constructor () {}
}