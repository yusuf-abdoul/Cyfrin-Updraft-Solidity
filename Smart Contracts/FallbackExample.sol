// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract FallbackExample {
    uint256 public result;

    receive() external payable { //special function, gets triggered when no calldata associated with txn 
        result = 1;
     }
    
    fallback() external payable {
        result = 2;
     }
}