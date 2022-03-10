// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// only creator can create new coins with minting function that we say in continues
// and anyone can send coins to eachother without need to register


contract Coin {
    address public minter;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor(){
        minter = msg.sender;
    }

    function minting(address receiver, uint amount)public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    error insufficientBalances(uint requested, uint available);
    function send(address receiver, uint amount) public{
        if(amount >balances[msg.sender])
        revert insufficientBalances({
            requested:amount,
            available:balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

  
}
