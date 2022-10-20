// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WaveMePortal {
    uint256 totalWaves;

    //Later, We will be using this for creating random number
    uint256 private seed;

    //Creating event, it helps in logging(cheap storage)
    event NewWave(address indexed from, uint256 timestamp, string message);

    //Creating struct(custom data type)
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint timestamp; // The timestamp when the user waved.
    }

    // declare a variable waves that lets me store an array of structs.
    // This is what lets me hold all the waves anyone ever sends to me!
    Wave[] waves;

    constructor() payable {
        console.log("YoYo! I am contract and I am smart, Now I can also pay");

        //Setting Initail Seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        //Generate a new seed for the next user that sends a wave
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        //Give a 50% chance that the user wins the prize.
        if (seed < 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
