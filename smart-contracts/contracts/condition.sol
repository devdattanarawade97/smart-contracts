// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;


contract check{



    uint value1=10;

    function checkIf(uint value) public  view  returns (bool){

      if(value==value1){

        return true;
      }
      else{
        return false;
      }
    }
}
