// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough");

        if(addressToAmountFunded[msg.sender] == 0){
            funders.push(msg.sender);
        }

        addressToAmountFunded[msg.sender] += msg.value;
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed =
            AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        (, int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns(uint256)
    {
        uint256 ethPrice = getPrice();
        return (ethPrice * ethAmount) / 1e18;
    }

    function withdraw() public {
        require(msg.sender == owner, "Must be owner");
        for(uint256 funderIndex=0; funderIndex<funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        // transfer
        payable(msg.sender).transfer(address(this).balance);
        //send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");

       (bool callSucces,)= payable(msg.sender).call{value: address(this).balance}("");
    }
}