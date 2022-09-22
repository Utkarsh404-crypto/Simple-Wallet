//SPDX-License-Identifier: UNLICENSED;
pragma solidity ^0.8.0;

import "./Allowance.sol";

contract Wallet is Allowance{

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function receiveMoney() external payable {

        emit MoneyReceived(msg.sender , msg.value);

    } 
       
    function withdrawMoney(address payable _to , uint _amount) public ownerOrAllowed(_amount){


        emit MoneySent(_to , _amount);

        require(_amount <= address(this).balance , "There are not enough funds");

        if(!isOwner()){
            reduceAllowance(msg.sender, _amount);
        }
            _to.transfer(_amount);
    }

  
}