// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    


    function compare(string memory a , string memory b) public pure returns(bool output){
        
       
        for(uint i=0;i<bytes(a).length;i++){

            if(bytes(a)[i]!=bytes(b)[i]){
                return false;
            }

          
        }
          return true;
    }
}
