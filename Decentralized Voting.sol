pragma solidity >=0.7.0 <0.9.0;
// We want to make a decentralized Voting

 //1.make a ability to accept the names and numbers and store them

 //2.ability of voting and keep track of them and authenticate
 //3.chairperson that authenticate and deploy the contract


contract Ballot {

    //we should add struct with this properties:
    //voters: voted or not,so this is boolean,    access to vote is uint because we'll add some features ,
    // and the last item is vote index so that is uint
    
    struct Voter {
        uint vote;
        bool voted;
        uint weight;
        
    }

    struct Proposal{
    bytes32 name;
    uint voteCount;

    }

    Proposal[] public proposals;
    mapping(address=> Voter) public voters;
    

    //chairperson is here
    address public chairperson;

    constructor(bytes32[] memory proposalNames){

        chairperson = msg.sender;

        //add 1 to chairperson weight
        voters[chairperson].weight=1;



    //will add the proposal names to the smart contract upon deployment
        for(uint i=0; i < proposalNames.length; i++){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount:0
            }));
        }
    }

    //here we should create three functions:
    //1.function authenticate votes
    //2.function for voting
    //3.function for showing the result

    function giveRightToVote(address voter)public {
        require(msg.sender == chairperson,'Only chairperson can give access to vote');
        require(!voters[voter].voted,'The voter has already voted');
        require(voters[voter].weight ==0);
        voters[voter].weight=1;

    }

    //function for voting
    function vote(uint proposal) public{
        Voter storage sender = voters[msg.sender];
        require(sender.weight !=0, 'Has no right to vote');
        require (!sender.voted, 'Already voted');
        sender.voted=true;
        sender.vote=proposal;

        proposals[proposal].voteCount +=sender.weight;
    
        
    }

    //function that shows the winning proposal by integer
    function winningProposal() public view returns(uint winningProposal_){
        
        uint winningVoteCount=0;
        for(uint i =0; i<proposals.length; i++){
            if(proposals[i].voteCount>winningVoteCount){
                winningVoteCount=proposals[i].voteCount;
                winningProposal_ = i;
            }
        }
    }

    //function that sjows the winner by name
    function winningName() public view returns(bytes32 winningName_){
        winningName_ = proposals[winningProposal()].name;
    }
  
    

}


