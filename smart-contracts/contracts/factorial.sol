// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract CalculateFactorial {
       //count number of duplicate characters
    bytes1[] collectionOfChar;
  
        mapping (bytes1=>bool)  checkChar;
       
     
    // this function calculates the factorial of a give number
    function countingDuplicate(string memory x) public  returns(uint duplicateCount){
      

            bytes memory y=bytes(x);
 
         for(uint i=0;i<bytes(x).length;i++){
              if(checkChar[y[i]]==false){
               collectionOfChar.push(y[i]);
               checkChar[y[i]]=true;
              }
              else {
                  duplicateCount=duplicateCount+1;
              }

         }

            return duplicateCount;
    }

}
