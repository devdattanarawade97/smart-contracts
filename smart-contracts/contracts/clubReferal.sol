// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

contract clubReferal{
    
// Club referral system
// Objective 

// This is a challenging task to help you apply your problem-solving skill using solidity with use of address and creating an famous referral system.

 

// Task Overview

// There is a swimming club named "swimmer's club" in Mumbai. In order to join the club one has to pay an amount of 1 ETH. If a new joiner has a referral address of the one who is already a member of the club, 10% of the joining amount is awarded to the referrer. note that this is compulsory that the referral address must be the present member of the club otherwise this offer will be invalid. Create a Smart contract that represents the club and functions to join the club.

// Task 

// 1. Create an array to store members addresses.

// 2. Create a function join so that when a new member has no referral address he/she can join directly using this function. after successful joining, add the new member address to the array.

// 3. Create a function join_referrer that accepts variable type addresses as an argument. Check if the referrer is already a member or not, if not then revert, if yes then transfer the award to the referrer's address and add a new user in the array.

// 4. Create a function get_members which returns the array of members that are declared in the first step.

// * the functions name should match as defined above
   
    address []  clubMembers;
    mapping (address=>bool) internal  isMember;
     address payable  immutable private clubOwner=payable (msg.sender);
    uint constant private  joiningAmount=1 ether;
    event logString(string);

    modifier validateUser(){

           require(msg.sender.balance>=joiningAmount, "sorry dont have enough balance");
            require(isMember[msg.sender]==false, "you are already member of club!!!");
            emit logString('user have enough balance');
            _;
        }


    function join() validateUser() public payable {
         require(msg.value==joiningAmount, "please send exactly 1 Ether to join club");
        clubOwner.transfer(msg.value);
        clubMembers.push(msg.sender);
        isMember[msg.sender]=true;
        emit logString('transaction succesfull and member added into club');

    }

   

    function join_referrer(address payable referrAddress) validateUser() public payable {

           require(isMember[referrAddress]==true,"referrraddess is not member of club");
           require(msg.value==joiningAmount, "please send exactly 1 Ether to join club");
              clubOwner.transfer((9*msg.value)/10);
              referrAddress.transfer((1*msg.value)/10);
              clubMembers.push(msg.sender);
              isMember[msg.sender]=true;
            emit logString('transaction succesfull and member added into club');

    }
   
  function get_members() public view returns(address[] memory){

         return clubMembers;
     }

}
