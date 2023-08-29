// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

contract Crow_Funding_Application {
    //@dev - non payable manager address and datatypes
    address private manager;
    uint256 private minContributionAmount;
    uint256 private targetAmount;
    uint256 private collectedAmount;
    uint256 private noOfContributors;
    uint256 private deadline;
    uint256 counter;
    CreateRequest newRequest;
    bool atLeastOneRequestToVote = false;

    //mapping
    mapping(address => uint256) contributorsLedger;
    mapping(address => bool) userExistOrNotLedger;
    mapping(address => CreateRequest) requestLedger;
    mapping(uint256 => CreateRequest) electionPanel;

    //events
    event logTransactionFlows(address, string, uint256);
    event logRequestFlows(address, CreateRequest);
    event logVoteFlows(address, string);
    event logAnnouceWinner(address, CreateRequest);

    struct CreateRequest {
        string requestDescription;
        address receiverAddress;
        uint256 amountNeeded;
        bool isAmountReceived;
        uint256 noOfVotesAcquired;
        uint256 requestCounter;
    }

    //@dev - constructor should be in a such a way

    constructor(uint256 _deadLine) {
        manager = (msg.sender);
        targetAmount = 60 ether;
        deadline = block.timestamp + _deadLine;
        minContributionAmount = 5 ether;
    }

    //@dev- validateContributor modifier
    modifier mapContributor() {
        if (userExistOrNotLedger[msg.sender] != true) {
            userExistOrNotLedger[msg.sender] = true;
            contributorsLedger[msg.sender] = 0;
        }
        _;
    }
    //@dev- validateContributor modifier
    modifier validateContributor() {
        require(
            userExistOrNotLedger[msg.sender] == true,
            "sorry !!! contribute first"
        );
        _;
    }

    function contribute() public payable mapContributor {
        //require Contribution amount should be greater than or equal to minContributionAmount ;
        //require Contribution  to be less or equal to user balance account
        //   uint256 contractBalance = address(this).balance;
        require(
            msg.sender != manager,
            "OOP's , manager not allowed to participate"
        );
        require(block.timestamp < deadline, "sorry !!! deadline has passed .");
        require(
            msg.value >= minContributionAmount,
            "minmum contribution amount not met"
        );
        require(msg.value <= msg.sender.balance, "OOP's insufficent fund !!!");

        // payable(address(this)).transfer(msg.value);

        contributorsLedger[msg.sender] =
            contributorsLedger[msg.sender] +
            msg.value;
        collectedAmount = collectedAmount + msg.value;
        noOfContributors += 1;

        emit logTransactionFlows(
            msg.sender,
            "money added successfully in contract address",
            contributorsLedger[msg.sender]
        );
    }

    function createAmountRequest(
        string memory _requestDescription,
        uint256 _amountNeeded
    ) external validateContributor returns (CreateRequest memory _newRequest) {
        //only contributors can create amount request
        //manager cannot create request

        require(
            address(this).balance == targetAmount,
            "contract balance not met to target Amount"
        );
        require(
            requestLedger[msg.sender].isAmountReceived == false,
            "sorry !!! cannot create Request. you have already received fund ."
        );
        require(
            requestLedger[msg.sender].requestCounter == 0,
            "OOP's !!! you have already raised request"
        );
        require(msg.sender != manager, "Dont cheat !!! you are manager");
        newRequest.requestDescription = _requestDescription;
        newRequest.receiverAddress = msg.sender;
        newRequest.amountNeeded = _amountNeeded;
        newRequest.isAmountReceived = false;
        newRequest.noOfVotesAcquired = 1;

        requestLedger[msg.sender] = newRequest;
        emit logRequestFlows(msg.sender, newRequest);
        atLeastOneRequestToVote = true;
        _newRequest = newRequest;

        counter++;
        return _newRequest;
    }

    function getRequest(address requestAddress)
        public
        view
        returns (CreateRequest memory request)
    {
        require(atLeastOneRequestToVote == true, "sorry !!! No Request Yet");

        return requestLedger[requestAddress];
    }

    function voteRequests(address voteTo) public {
        //require requestledger should have atleast one request;
        //require only contributor can vote
        //require voters cannot vote themselves
        require(
            contributorsLedger[msg.sender] > 0,
            "sorry !!! You Should Contribute First to Vote"
        );
        require(msg.sender != voteTo, "sorry !!! you can not vote yourself");
        require(atLeastOneRequestToVote == true, "sorry !!! No Request Yet");
        uint256 pastVoteCount = requestLedger[voteTo].noOfVotesAcquired;
        requestLedger[voteTo].noOfVotesAcquired =
            requestLedger[voteTo].noOfVotesAcquired +
            1;
        electionPanel[counter] = requestLedger[voteTo];
        counter++;
        assert(requestLedger[voteTo].noOfVotesAcquired == pastVoteCount + 1);
        emit logVoteFlows(msg.sender, "congrats! you have voted successfully");
    }

    function makePayment() external returns (CreateRequest memory _winner) {
        //require manager only can intiate this function
        //after making payment vote function should have to stop , as winner announced .
        //winner should receive amount at one time only

        require(
            msg.sender == manager,
            " Don't cheat !!! , you are not manager"
        );

        uint256 tempWinnerCount = 0;
        CreateRequest memory winner;
        for (uint256 i = 0; i < counter; i++) {
            winner = electionPanel[i];
            require(winner.isAmountReceived == false);
            if (winner.noOfVotesAcquired > tempWinnerCount) {
                tempWinnerCount = winner.noOfVotesAcquired;
                _winner = winner;
            }
        }
        payable(_winner.receiverAddress).transfer(_winner.amountNeeded * 1e18);
        requestLedger[_winner.receiverAddress].isAmountReceived = true;
        _winner = requestLedger[_winner.receiverAddress];
        emit logAnnouceWinner(_winner.receiverAddress, _winner);
        return _winner;
    }

    //dev - getContractBalance fetches contract balance which have visibility scope as view;

    function getContractBalance() external view returns (uint256) {
        require(
            userExistOrNotLedger[msg.sender] == true,
            "sorry!!! contribute first"
        );
        return address(this).balance;
    }
}
