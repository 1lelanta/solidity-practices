// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public listOfsimpleStorage;

    function createSimpleStorage() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfsimpleStorage.push(newSimpleStorageContract);
        
    }
}