// When I was reading the doc of solidity and I examined it ,every part that was important ,I put here for using:
//Here you are:

//The following contract implements the simplest form of a cryptocurrency. The contract allows only its creator to create
//new coins (different issuance schemes are possible). Anyone can send coins to each other without a need for registering
//with a username and password, all you need is an Ethereum keypair.

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
contract Coin {
// The keyword "public" makes variables
// accessible from other contracts
address public minter;
mapping (address => uint) public balances;
// Events allow clients to react to specific
// contract changes you declare
event Sent(address from, address to, uint amount);
// Constructor code is only run when the contract
// is created
constructor() {
minter = msg.sender;
}
// Sends an amount of newly created coins to an address
// Can only be called by the contract creator
function mint(address receiver, uint amount) public {
require(msg.sender == minter);
balances[receiver] += amount;
}
// Errors allow you to provide information about
// why an operation failed. They are returned
// to the caller of the function.
error InsufficientBalance(uint requested, uint available);
// Sends an amount of existing coins
// from any caller to an address
function send(address receiver, uint amount) public {
if (amount > balances[msg.sender])
revert InsufficientBalance({
requested: amount,
available: balances[msg.sender]
});
balances[msg.sender] -= amount;
balances[receiver] += amount;
emit Sent(msg.sender, receiver, amount);
}
}
