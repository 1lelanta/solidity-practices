// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// string is squence of character listed iside quatation mark
contract learnStrings {
 string greeting = "hello";

 function sayHello()  public  view returns(string memory){
    // momory is like ram it wiped out after function execution is finished 
    return greeting;

 }

 function changeGreeting(string memory _change) public {
    greeting = _change;
 }

 function getChar() public view returns(uint){
    // getting length of character in solidity is to expensive 
    // it is impossible to get length of string as other languages
    // but we can do it by parsing string or casting to the bytes
    bytes memory stringTobytes = bytes(greeting);
    return stringTobytes.length;
 }
}