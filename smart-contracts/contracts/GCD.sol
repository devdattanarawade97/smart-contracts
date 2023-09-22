// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract GCDTest {

    //this function calculates the GCD (Greatest Common Divisor)
    function gcd(uint a, uint b) public  pure returns (uint) {
       
       uint diff=0;
        if(a>b){
             
            diff=a-b;
        }else{

            diff=b-a;
        }

        uint GCD=0;
        for(uint i=1;i<=diff;i++){
           
          if(a%i==0&&b%i==0){
            GCD=i;
          }

        }
          return GCD;
    }

}
