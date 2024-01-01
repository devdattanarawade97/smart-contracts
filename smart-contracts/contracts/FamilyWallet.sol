// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract DFamilyWallet {
    address private fatherAddress;
    uint256 public  DWalletBalance;
    mapping(address => uint256) famliyPocketMoneyLeadger;

    address payable[] familyAddressLeadger;



  
    constructor()  payable  {
        fatherAddress = msg.sender;
        DWalletBalance=msg.value;
    }


    modifier onlyFather() {
        require(msg.sender == fatherAddress);
        _;
    }

      
    function setMoneyToLeadger(uint256 money, address payable familyAddress)
        public
        onlyFather
    {
        famliyPocketMoneyLeadger[familyAddress] = money;
        familyAddressLeadger.push(familyAddress);
    }

    function payPocketMoney() public onlyFather {
        for (uint256 i = 0; i < familyAddressLeadger.length; i++) {
            familyAddressLeadger[i].transfer(
                famliyPocketMoneyLeadger[familyAddressLeadger[i]]*10**18
            );
        }
    }
}
