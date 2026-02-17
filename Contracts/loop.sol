// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract loopContract{

    uint[] public numbers = [1,2,3,4,5,6,7,8,9];

    function checkMultiple(uint _number) public view  returns(bool){

        for(uint i = 0; i< numbers.length; i++){
            checkMultiples(numbers[i], _number);

    }


    function checkMultiples(uint _num, uint _nums) public view returns(bool){

        if(_num % _nums==0){
            return true;
        }
        else{
            return false;
        }
    }
}