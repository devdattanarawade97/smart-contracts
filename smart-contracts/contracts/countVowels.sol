// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract countVowel {
       //count number of duplicate characters

  
       bytes constant vowels='aeiou';
     
    // this function calculates the factorial of a give number
    function countVowels(string memory x) public pure   returns(uint){
      

            bytes memory y=bytes(x);
            
       
           uint vowelCount=0;

           
         for (uint i = 0; i < y.length; i++) {
                

                for(uint z=0;z<vowels.length;z++){
                     
                     if(y[i]==vowels[z]){
                         vowelCount++;
                     }

                }
        }

            return vowelCount;
    }

}
