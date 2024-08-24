/*
Layout of Contract:
version
imports
errors
interfaces
libraries
contracts

Inside contract:
Type declarations
State variables
Events
Modifiers
Functions

Layout of Functions:
constructor
receive function (if exists)
fallback function (if exists)
external
public
internal
private
view & pure functions
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title Raffle Contract
 * @author Yash Khanvilkar
 * @notice This Contract is for creating a sample raffle
 * @dev  Implements CHainlink VRFv2.5
 */

contract Raffle {
    /* Errors */
    error Raffle__SendMoreToEnterRaffle();
    error Raffle__TransferFailed();
    error Raffle_RaffleNotOpen();
    error Raffle__UpkeepNotNeeded(
        uint256 balance,
        uint256 playersLength,
        uint256 s_raffleState
    );

    /* Type Declarations */
    enum RaffleState {
        OPEN,
        CALCULATING
    }

    /* State Variables */
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    /* Events */
    event RaffleEntered(address indexed player);
    event WinnerPicked(address indexed winner);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        // require(msg.value >= i_entranceFee, "Not enough ETH sent.");
        // require(msg.value >= i_entranceFee, SendMoreToEnterRaffle()); // only works on very specific versions of solidity

        if (msg.value < i_entranceFee) {
            revert Raffle__SendMoreToEnterRaffle();
        }

        s_players.push(payable(msg.sender));
        //whenever we update a storage variable, we should emit an event
        //1. Makes migration easier
        //2. Makes front end "indexing" easier
        emit RaffleEntered(msg.sender);
    }

    function pickWinner() public {}

    /* Getters */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
