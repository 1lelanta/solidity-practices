// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {SimpleStorage} from './SimpleStorage.sol';

contract StorageFactory{
    SimpleStorage[] public listOfsimpleStorage;

    function createSimpleStorage() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfsimpleStorage.push(newSimpleStorageContract);
        
    }
    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        SimpleStorage mySimpleStorage = listOfsimpleStorage[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);
        
    }
}