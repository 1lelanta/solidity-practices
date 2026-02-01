// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Ballot{

    // shows what one voter looks like 
    struct Voter{
        uint weight; // weight of the voting power 
        bool voted; // to avoid voting twice
        address delegate;// delegate address if any
        uint vote; // index of the voted proposal
    }

    // proposal structure
    struct Proposal{
        bytes32 name;  // small proposal name 
        uint voteCount; // vote counter 
    }
    // gives right to vote 
    address public  chairperson ;// address where contract is deployed

    //map  every address to exactly  one voter record;
    mapping (address=> Voter) public voters; // creates data base key ethereum address value voters

    //create an array of proposal to store each propasal on storage
    Proposal [] public  propasals; 
}