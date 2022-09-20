//SPDX-License-Identifier: UNLICENSED;
pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Wallet is Ownable{

    mapping (address => uint) allowance;
    address _owner;

    constructor() {
        _owner = msg.sender;
    }

    
   function isOwner() public view returns(bool) {

       return _owner == msg.sender;

   }


   function receiveMoney() public payable {

    } 
    
    function addAllowance(address _who , uint _amount) external onlyOwner{

             allowance[_who] = _amount;

    }


    modifier ownerOrAllowed(uint _amount){
        require(isOwner() || allowance[msg.sender] >= _amount , "You are not allowed");
        _;
    }


    function withdrawMoney(address payable _to , uint _amount) public ownerOrAllowed(_amount){
            _to.transfer(_amount);
    }

  
}