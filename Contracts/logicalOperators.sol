// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.8;

contract LogicalOperators{
    uint a = 6;
    uint b = 8;

    function logic() public view returns(uint){
        uint result = 0;
        if(b >a && a == 6){
            result = a + b;
        }

        return result;
    }
}