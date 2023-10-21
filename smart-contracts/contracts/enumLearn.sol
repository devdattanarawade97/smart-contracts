// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;


contract enumLearn{



    enum pizzaSize{

        large , small , medium
    }


    function getPizza() public pure   returns (pizzaSize){


        return pizzaSize.small;
    }




}
