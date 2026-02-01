// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Ballot{
    struct voter{
        uint weight; // weight of the voting power 
        bool voted; // to avoid voting twice
        address delegate;// delegate address if any
        uint vote; // index of the voted proposal
    }
}