# Solidity API

## MBD_BANK

### Contract
MBD_BANK : contracts/MBD_Bank.sol

 --- 
### Modifiers:
### mapUser

```solidity
modifier mapUser()
```

### validateUser

```solidity
modifier validateUser()
```

 --- 
### Functions:
### depositMoney

```solidity
function depositMoney() public payable
```

### getBalance

```solidity
function getBalance() public view returns (uint256 _userBalance)
```

### checkMBDBalance

```solidity
function checkMBDBalance() external view returns (uint256 _MBD_Balance)
```

### transferAmount

```solidity
function transferAmount(address payable receiverAddress, uint256 amount) public payable returns (uint256 updatedBalance)
```

### withdrawAmount

```solidity
function withdrawAmount(uint256 amount) external
```

 --- 
### Events:
### logTransactionFlow

```solidity
event logTransactionFlow(address, string, uint256)
```

