// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// get funds from the user 
// withdraw funds 
// set minimum funding value in USD

uint256 public  minimumUsd = 5;

contract FundMe{
    function fund() public payable {
        require(msg.value >=minimumUsd, "didn't send enough");
    

    }
function getPrice(){
    // address 
    //ABI= Application Binary Interface. that tells outside world how to contact with that contract it is like a json 
}
function getConversionRate(){}

}