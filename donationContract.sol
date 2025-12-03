// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
   SIMPLE DONATION CONTRACT
   -------------------------
   • Anyone can donate ETH
   • Contract keeps track of each donor's total donations
   • Owner (deployer) can withdraw collected funds
   • Public functions allow transparency
*/

contract DonationContract {

    address public owner;                      // Owner of the contract
    mapping(address => uint256) public donations;   // Track donation amounts
    
    event Donated(address indexed donor, uint256 amount);
    event Withdrawn(address indexed owner, uint256 amount);

    constructor() {
        owner = msg.sender; // Set deployer as owner
    }

    // Modifier: Only owner can run certain functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized, only owner allowed!");
        _;
    }

    // Anyone can donate ETH
    function donate() public payable {
        require(msg.value > 0, "Donation must be more than 0");

        donations[msg.sender] += msg.value;

        emit Donated(msg.sender, msg.value);
    }

    // Owner can withdraw all the funds collected
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available to withdraw");

        payable(owner).transfer(balance);

        emit Withdrawn(owner, balance);
    }

    // Get total balance inside contract
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
