// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract CalculateFactorial {
       //count number of duplicate characters

  
       
     
    // this function calculates the factorial of a give number
    function countingDuplicate(string memory x) public pure   returns(string memory ){
      

            bytes memory y=bytes(x);
            
           bytes memory reverseString=new bytes(y.length);
         for (uint i = 0; i < y.length; i++) {
            reverseString[y.length - 1 - i] = y[i];
        }

            return string(reverseString);
    }

}
