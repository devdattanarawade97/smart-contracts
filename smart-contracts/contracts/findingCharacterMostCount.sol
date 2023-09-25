// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract  findingCharacterMostCount {


    mapping (bytes1=>uint) charCount;
       mapping (bytes1=>bool) charCheck;


    function find(string memory givenString) public  returns (uint){
     
       bytes memory bytesGivenString=bytes(givenString);
     

       for(uint i=0;i<bytesGivenString.length;i++){
            
           if(charCheck[bytesGivenString[i]]){
                  charCount[bytesGivenString[i]]=charCount[bytesGivenString[i]]+1;

           }else{
charCheck[bytesGivenString[i]]=true;
                charCount[bytesGivenString[i]]=1;

           }
     
           
       }
          uint count=0;
         for(uint i=0;i<bytesGivenString.length;i++){
            
           if(charCount[bytesGivenString[i]]>count){
              
              count=charCount[bytesGivenString[i]];

           }
     
           
       }

       return  count;




    }
    
}
