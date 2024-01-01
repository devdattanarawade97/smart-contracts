// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract CryptoCoin {
    address private minter;
    mapping(address => uint256) coinsLeadger;

    constructor() {
        minter = msg.sender;
    }

    modifier onlyMiner() {
        msg.sender == minter;
        _;
    }

    //coins minter
    function mintCoins(address receiver, uint256 amount) public onlyMiner {
        coinsLeadger[receiver] += amount;
    }

    //send functionality
    function sendCoins(address receiver, uint256 amount) public {
        require(coinsLeadger[msg.sender] >= amount,"insufficent balance");
        coinsLeadger[msg.sender] -= amount;
        coinsLeadger[receiver] += amount;
    }
}
