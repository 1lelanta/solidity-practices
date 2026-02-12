
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract WelcomeToSolidity{
    constructor(){}

    function getResult() public view returns(uint){
        uint a = 12;
        uint b = 13;

        uint result = a + b;

        return result;
    }
}