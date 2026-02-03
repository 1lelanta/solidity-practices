// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// get funds from the user 
// withdraw funds 
// set minimum funding value in USD



contract FundMe{
    

    uint256 public  minimumUsd = 5;

    function fund() public payable {
        require(msg.value >=minimumUsd, "didn't send enough");
    

    }
        function getPrice(){
            // address  0x694AA1769357215DE4FAC081bf1f309aDC325306
            //ABI= Application Binary Interface. that tells outside world how to contact with that contract it is like a json 
        }
        function getConversionRate(){}

}