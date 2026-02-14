// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// variables scope
//private = you can only call the function inside the contract 
//Internal = called only within the contract or other contract that inherit that contract 
//external  = called only outside the contract 
// public  =  call the function from outside the smart contract as well as inside the contract 


contract d {
    uint data = 10;
    function x() public view returns(uint){
        return data;
    }
    function y () public  view returns(uint){
        return data;
    }
}