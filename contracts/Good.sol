// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Good {
    address public currentWinner;
    uint256 public currentAuctionPrice;

    mapping(address => uint256) public balances; // Prevention

    constructor() {
        currentWinner = msg.sender;
    }

    function setCurrentAuctionPrice() public payable {
        require(
            msg.value > currentAuctionPrice,
            "Need to pay more than the currentAuctionPrice"
        );
        balances[currentWinner] += currentAuctionPrice;
        currentAuctionPrice = msg.value;
        currentWinner = msg.sender;
        // ------ Old Code ------

        // Sending back the ETH of the last bidder

        // (bool sent, ) = currentWinner.call{value: currentAuctionPrice}("");

        // local sent is assigned the returned bool (T if success, F if failed)
        // , leave all other variables

        // Setting the current owner
        // if (sent) {
        //    currentAuctionPrice = msg.value;
        //    currentWinner = msg.sender;
        //}
    }

    // Prevention of DoS Attack
    function withdraw() public {
        require(msg.sender != currentWinner, "Current winner cannot withdraw");

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;
        // Setting the balance to "0" before sending ETH back, why?
        // To prevent Re-entrancy attack
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
