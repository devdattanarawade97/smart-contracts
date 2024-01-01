// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;



contract SimpleStorage {



  string public data;


  //setter function to store the data;

  function setter(string memory setterData) public {


    data=setterData;
  }

  //getter function with view visiblity 

   function getter() public view returns(string memory returnData) {

    returnData=data;
   }


    
}