// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable{

    using SafeMath for uint;

    event AllowanceChhange(address indexed _forWho, address indexed  _fromWhom , uint _oldAmount , uint _newAmount);
  
    mapping (address => uint) public allowance;
 
    address _owner;

    constructor() {
        _owner = msg.sender;
    }

    
    function isOwner() public view returns(bool) {

       return _owner == msg.sender;

   }

    function addAllowance(address _who , uint _amount) external onlyOwner{

         emit AllowanceChhange(_who , msg.sender , allowance[_who] , _amount);
         allowance[_who] = _amount;

    }

    function reduceAllowance(address _who , uint _amount) internal {

        emit AllowanceChhange(_who , msg.sender , allowance[_who] ,allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }


    modifier ownerOrAllowed(uint _amount){
        require(isOwner() || allowance[msg.sender] >= _amount , "You are not allowed");
        _;
    }

}