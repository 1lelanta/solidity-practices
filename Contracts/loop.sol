// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract loopContract{


    function checkMultiples(uint _num, uint _nums) public view returns(bool){

        if(_num % _nums==0){
            return true;
        }
        else{
            return false;
        }
    }
}