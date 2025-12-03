// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ownable {
    address public owner;
    uint256 public serviceFee;
    mapping(address => string) public userMessages;

    constructor() {
        owner = msg.sender;
        serviceFee = 1 ether; // default
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    function setOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }

    function onlyOwnerCanAccess() public onlyOwner {
        // OWNER-ONLY LOGIC
        // Example: change service fee
        serviceFee = 0.05 ether;
    }

    function anyOneCanAccess(string memory message) public {
        // PUBLIC LOGIC
        // Example: save a message
        userMessages[msg.sender] = message;
    }
}
