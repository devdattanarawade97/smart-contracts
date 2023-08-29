// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

//@title - MBD_BANK is decentralized bank application where user can deposit money, withdraw ,transfer as well as can check own balance as well as MBD bank balance. user can directly register with MBD bank simply by deposting amount > 0 in MBD bank .MBD decentralized bank safe and secure in terms of features like decentralized nature, only registered MBD bank user will be able to perform access features like transferamount , withdrawamount , check MBD bank balance and user account balane. MBD bank balance publically visible to only MBD bank users. any one can participate in this contract just by depositing any amount greater than zero . every participant will be owner of this contract . there is no central authority managing this contract or ledger.
//@author - Devdatta
contract MBD_BANK {
    //@dev - we are mapping user address and balance using other mapping named 'userExistOrNot'. if user is new in this contract then we are mapping it first in 'userExitOrNot' and then mapping it into 'balanceLedger'
    mapping(address => uint256) balanceLedger;

    //@dev - we are mapping every new user with boolean status as true.
    mapping(address => bool) userExistOrNot;

    //@dev - logging user address , custom message and user balance .
    event logTransactionFlow(address, string, uint256);

    //@dev - mapping new user using mapUser modifier . this modifier is applicable to only depositAmount function only .there after user able to access other features.
    modifier mapUser() {
        if (userExistOrNot[msg.sender] != true) {
            userExistOrNot[msg.sender] = true;
            balanceLedger[msg.sender] = 0;
            require(userExistOrNot[msg.sender] = true);
            require(balanceLedger[msg.sender] == 0);
            emit logTransactionFlow(
                msg.sender,
                "New User mapped successfully",
                balanceLedger[msg.sender]
            );
        }
        _;
    }

    //@dev - we are validating user before accessing features like withdraw amount , transfer amount, get balance function and while checking MBD bank balance.
    modifier validateUser() {
        require(
            userExistOrNot[msg.sender] == true,
            "OOP's , You are not MBD Bank customer"
        );
        _;
    }

    //@notice - user can deposit amount in MBD bank using 'depositMoney' function
    function depositMoney() public payable  mapUser {
        //require deposit amount greater than zero
        //require deposit amount should be less than account balance

        require(
            msg.value > 0,
            "Invalid Amount!!! Amount should be greater than zero"
        );
        require(
            msg.value <= msg.sender.balance,
            "insufficent balance!!! Amount should be less or equal to your current balance"
        );
        balanceLedger[msg.sender] = balanceLedger[msg.sender] + msg.value;
        emit logTransactionFlow(
            msg.sender,
            "Money deposited successfully to MBD Bank",
            balanceLedger[msg.sender]
        );
    }

    //@notice - user can check there account balance using this 'getAccountBalance' function
    //@return - this function return user account balance .
    function getBalance() public view returns (uint256 _userBalance) {
        require(
            userExistOrNot[msg.sender] == true,
            "OOP's , You are not registered with MBD"
        );
        _userBalance = balanceLedger[msg.sender];
    }

    //@notice - user can check MBD bank balance using this 'checkMBDBalance' function
    function checkMBDBalance() external view returns (uint256 _MBD_Balance) {
        require(
            userExistOrNot[msg.sender] == true,
            "OOP's , You are not MBD Bank customer"
        );
        _MBD_Balance = address(this).balance;
    }

    //@notice - user can transfer amount to another account address using 'transferAmount' functionn .added validation like receipent and sender should be MBD bank customer. 
    //@param - transferAmount function takes receiver address  and amount which is sending to receipent
    //@return this fucntion returns contract owner updated balance after successful transfering amount
    function transferAmount(address payable receiverAddress, uint256 amount)
        public
        payable
        validateUser
        returns (uint256 updatedBalance)
    {
        //require sender address balance greater or equal to  amount
        //require sender address to be greater than zero
        uint256 senderOldBalance = balanceLedger[msg.sender];
        uint256 receiverOldBalance = balanceLedger[receiverAddress];

        require(
            userExistOrNot[receiverAddress] == true,
            "OOP's , receipent is not MBD Bank customer"
        );

        require(
            amount > 0,
            "invalid Amount!!! amount should be greater than zero"
        );

        require(
            balanceLedger[msg.sender] >= amount,
            "insufficent balance to perform this transaction"
        );

        receiverAddress.transfer(amount);
        balanceLedger[msg.sender] = senderOldBalance - amount;
        balanceLedger[receiverAddress] = receiverOldBalance + amount;
        emit logTransactionFlow(
            msg.sender,
            "Money deducted successfully",
            balanceLedger[msg.sender]
        );
        emit logTransactionFlow(
            receiverAddress,
            "Money transfered  successfully",
            balanceLedger[receiverAddress]
        );

        updatedBalance = balanceLedger[msg.sender];
    }

    //@notice - user can withdraw amount from MBD bank using 'withdrawAmount' function . only MBD bank user will be able to perform this funtion.
    //@param this fuction takes amount as input which we want to withdraw from
    function withdrawAmount(uint256 amount) external validateUser {
        //require user balance should be greater or equal to entered amount

        require(
            amount > 0,
            "invalid amount!!! amount should be greater than zero"
        );
        require(
            balanceLedger[msg.sender] >= amount,
            "insufficent balance to perform this transaction"
        );
        payable(msg.sender).transfer(amount);
        balanceLedger[msg.sender] = balanceLedger[msg.sender] + amount;

        emit logTransactionFlow(
            msg.sender,
            "Amount withdrawn successfully to your account",
            balanceLedger[msg.sender]
        );
    }
}
