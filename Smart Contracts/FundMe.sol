// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

//import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

// creating a custom error instead of using "require for gas optimization
error notOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;  //gas optimization keyword "constant" with variable in capslock

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    
    address public immutable i_owner; //gas optimization keyword "immutable" with varible having "i_"
    
    constructor() {
        i_owner = msg.sender;
    } 
    
    function fund() public payable {
        //Allow users to send funds
        // Set a minimum $ sent
        // 1. How do we send ETH to this.
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough ETH "); // 1e18 = 1 ETH = 1
        funders.push(msg.sender);
        // addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        addressToAmountFunded[msg.sender] += msg.value;
    }
    
    function withdraw() onlyOwner public {
        // for loop
        //for (/* startingIndex, endingIndex, step amount */)
        //require(msg.sender == owner, "Must be the owner!"); deleting this to create a modifier
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
           address funder = funders[funderIndex];
           addressToAmountFunded[funder] = 0;
        }
        // resetting the array funders[]
        funders = new address[](0);

        //3 different ways to actually withdraw the funds
        //transfer : automatically reverts if the transfer fails
        // msg.sender = address type while payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);
        // //send : only reverts if there is a "require" keyword
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        //call bytes memory dataReturned
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }
    
    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not the owner");
        if (msg.sender != i_owner) {
            revert notOwner();
        }
        _;
    }

    // what happens when ETH is sent to this contract without callimg the fund function

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
     }

}
