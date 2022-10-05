// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WaveMePortal {
    uint256 totalWaves;

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

    constructor() {
        console.log("YoYo! I am contract and I am smart");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
