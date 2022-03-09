// SPDX-License-Identifier: MIT
pragma solidity ^0.5.7;

contract Will{
    address owner;
    uint fortune;
    bool notLive;
    
    constructor() payable public {
        owner = msg.sender;
        fortune = msg.value;
        notLive = false;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier mustNotToLive {
        require(notLive == true);
        _;
    }
    // list of family wallet
    address payable[] familyWallet;

    //mapping through inheritance
    mapping (address => uint) inheritance;

    //set inheritance for each address
    //example for this function : Chris has x amount
    function setInheritance(address payable wallet, uint amount) public onlyOwner{
        familyWallet.push(wallet);
        inheritance[wallet] = amount;
    }
    
    //paid each family member based on wallet
    function payout() private mustNotToLive{
        for(uint i =0; i <familyWallet.length; i++ ){
            familyWallet[i].transfer(inheritance[familyWallet[i]]);
        }
    }

    function hasNotLive() public onlyOwner{
        notLive = true;
        payout();
    }
  

}
