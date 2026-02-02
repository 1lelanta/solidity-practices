// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Ballot{

    // shows what one voter looks like 
    struct Voter{
        uint weight; // weight of the voting power 
        bool voted; // to avoid voting twice
        address delegate;// delegate address if any
        uint vote; // index of the voted proposal
    }

    // proposal structure
    struct Proposal{
        bytes32 name;  // small proposal name 
        uint voteCount; // vote counter 
    }
    // gives right to vote 
    address public  chairperson ;// address where contract is deployed

    //map  every address to exactly  one voter record;
    mapping (address=> Voter) public voters; // creates data base key ethereum address value voters

    //create an array of proposal to store each propasal on storage
    // public creates getter function for individual proposals 
    Proposal [] public  proposals; 

    //constructor runs once upon deployment initializes proposals
    constructor(bytes32[] memory proposalNames){
        //set chair deployer
        chairperson = msg.sender;

        // give chairperson voting power 
        // chairperson can vote immediately other should wait for approval
        voters[chairperson].weight = 1;
        // create the proposasl 
        for(uint i=0; i<proposalNames.length;i++){
            proposals.push(Proposal({
                name:proposalNames[i],
                voteCount:0
            }));

        }
    }
    // allow chairperson to authorize voters
    function giveRightToVote(address voter) external{
        require(msg.sender == chairperson, "Only chairperson can give right to vote. "); // prevents unothorized users from granting voting rights
        require(!voters[voter].voted, "The voter already voted. ");
        require(voters[voter].weight ==0);// voting rights given only once
        voters[voter].weight = 1; //gives the voter exactly one vote
    }
    // Delegate vote
    function delegate(address to ) external{
        // allow voter to transfer their voting power
        Voter storage sender = voters[msg.sender];// ? creates reference
        require(sender.weight !=0, "you have no right to vote");
        require(!sender.voted, "you have already voted");
        require(to!=msg.sender, "Self-delegation is disallowed");

        while(voters[to].delegate !=address(0)){
            to = voters[to].delegate;
            require(to!=msg.sender, "Found loop in delegation");
        }
        Voter storage delegate_ = voters[to];
        require(delegate_.weight>=1);
        // mark sender as voted
        sender.voted = true;
        sender.delegate = to;

        // transfer vote power
        if(delegate_.voted){
            proposals[delegate_.vote].voteCount +=sender.weight;
        }
         else{
                delegate_.weight+=sender.weight;
            }
    }
    //vote function
    function vote(uint proposal) external {
        // allow direct voting 
        //load sender 
        Voter storage sender = voters[msg.sender];

        //validation 
        require(sender.weight !=0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        // record the vote
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }
    //Winning proposal
    function winningProposal() public view returns(uint winingProposal_){
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
            winningVoteCount = proposals[p].voteCount;
            winningProposal_ = p;
        }
        }
        function winnerName() external view returns (bytes32 winnerName_){
            winnerName_ = proposals[winningProposal()].name;

        }

        }