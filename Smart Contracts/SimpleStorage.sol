// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; //solidity version

contract SimpleStorage{
    //favoriteNumber variable get initialized to 0 if no value is assigned
    uint256  myFavoriteNumber; // 0

    struct Person{
        uint256 favoriteNumber;
        string name;
    }
    // dynamic array
    Person[] public listOfPeople; // [] an empty list

    mapping(string => uint256) public nameToFavoriteNumber; 

    function store(uint256 _favoriteNumber) public virtual {
        myFavoriteNumber = _favoriteNumber; // + 5
    }

    function retrieve() public view returns(uint256){
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push( Person(_favoriteNumber, _name) );
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}


