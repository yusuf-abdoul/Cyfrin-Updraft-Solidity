// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; // solidity version

import {SimpleStorage} from "./SimpleStorage.sol";
contract StorageFactory {
     //  uint256 public favoriteNumber
    // type visibility name
    SimpleStorage[] public listOfSimpleStorageContracts; //array of SimpleStorage contracts

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract  = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);

    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // Address
        // ABI - Application Binary interface
        // SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        listOfSimpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        //SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }

}