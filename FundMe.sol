// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 5e18;

    address[] public founders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough");

        if(addressToAmountFunded[msg.sender] == 0){
            founders.push(msg.sender);
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
}