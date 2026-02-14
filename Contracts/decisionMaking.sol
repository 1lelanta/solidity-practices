// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract DecisionMaking {
    uint bag = 6;

    function validateBag() public view returns(bool){
        if(bag==6){
            return true;
        }
        else{
            return false;
        }
    }

}