// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Ballot {

    // shows what one voter looks like 
    struct Voter {
        uint weight;        // weight of the voting power 
        bool voted;         // to avoid voting twice  default to false 
        address delegate;   // delegate address if any
        uint vote;          // index of the voted proposal
    }

    // proposal structure
    struct Proposal {
        bytes32 name;       // small proposal name 
        uint voteCount;     // vote counter 
    }

    // address that deployed the contract
    address public chairperson;

    // map every address to exactly one voter record
    mapping(address => Voter) public voters;

    // array of proposals stored in contract storage
    Proposal[] public proposals;

    // constructor runs once upon deployment
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;

        // chairperson can vote immediately
        voters[chairperson].weight = 1;

        // create proposals
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(
                Proposal({
                    name: proposalNames[i],
                    voteCount: 0
                })
            );
        }
    }

    // allow chairperson to authorize voters
    function giveRightToVote(address voter) external {
        require(msg.sender == chairperson, "Only chairperson can give right to vote.");
        require(!voters[voter].voted, "The voter already voted.");
        require(voters[voter].weight == 0, "Voter already has voting rights.");

        voters[voter].weight = 1;
    }

    // delegate vote
    function delegate(address to) external {
        Voter storage sender = voters[msg.sender];

        require(sender.weight != 0, "You have no right to vote.");
        require(!sender.voted, "You have already voted.");
        require(to != msg.sender, "Self-delegation is disallowed.");

        // follow delegation chain
        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            require(to != msg.sender, "Found loop in delegation.");
        }

        Voter storage delegate_ = voters[to];
        require(delegate_.weight >= 1, "Delegate has no right to vote.");

        // mark sender as voted
        sender.voted = true;
        sender.delegate = to;

        // transfer vote power
        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            delegate_.weight += sender.weight;
        }
    }

    // vote directly
    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];

        require(sender.weight != 0, "Has no right to vote.");
        require(!sender.voted, "Already voted.");

        sender.voted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount += sender.weight;
    }

    // compute the winning proposal index
    function winningProposal() public view returns (uint winningProposal_) {
        uint winningVoteCount = 0;

        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    // return the name of the winning proposal
    function winnerName() external view returns (bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }
}
