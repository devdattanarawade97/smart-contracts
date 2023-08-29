// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Lotter_Winner {
    address private manager;
    //@dev mapping participants with theirs address
    address payable[] participantsLedger;
    event logAnnouceWinner(address , string , uint);
    //@dev contructor for setting manager address
    constructor() {
        manager = msg.sender;
    }

    //@notice user can participate in this competition using this function
    //@dev
    function participate() public payable  {
        require(
            msg.sender != manager,
            "sorry !!! manager cant contribute in this"
        );
      
        require(
            msg.value == 1 ether,
            "Wrong Amount !!! amount should be equal to 1 ETHER"
        );
      
        participantsLedger.push(payable(msg.sender));
    }

    //@dev random generator

    function generateRandomWinner() internal  view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        participantsLedger.length
                    )
                )
            );
    }

    //@notice makepayment funtion makes payment to winner
    //@dev rules to followed - only manager can call this function , requires participant to 5

    function makePayment() public  payable {
        require(
            msg.sender == manager,
            "OOPS!, Dont cheat !!. you are not manager"
        );
        require(
            participantsLedger.length == 5,
            "participant limit has not met yet!!!"
        );
        address payable winner;
        uint256 randomWinner = generateRandomWinner();
        uint256 randomIndex = randomWinner % participantsLedger.length;
        winner = participantsLedger[randomIndex];
        winner.transfer(address(this).balance);
      emit  logAnnouceWinner(winner,"Congrats !!! you have won lottery . amount credited successfully to your account" ,winner.balance );
        participantsLedger = new address payable[](0);
    }

    //@dev
}
