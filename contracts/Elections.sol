pragma solidity ^0.5.1;

contract Elections {

	struct Voter {
		uint rightToVote;
		bool voted; //If true, Voter already voted in election
	}

	struct Election {
		bytes32 name;
		uint voteCount;
		uint256 openingTime;
		uint256 closingTime;
		Proposal[] proposals;
	}

	struct Proposal {
		bytes32 name;
		uint voteCount;
	}


	address public chairPerson;
	mapping(address => Voter) public voters;
	Election[] public elections;

	modifier onlyChairPerson() {
		require(msg.sender == chairPerson);
		_;
	}

	constructor() public {
		chairPerson = msg.sender;
		voters[chairPerson].rightToVote = 1;
	}

	/**
	* @dev vote for a proposal
	* @param _election index of election to vote
	* @param _proposal index of proposal to vote
	*/
	function vote(uint _election, uint _proposal) public {
		Voter storage sender = voters[msg.sender];
		require(!sender.voted, "You already voted.");

		sender.voted = true;
		elections[_election].proposals[_proposal].voteCount += 1;
	}


	/**
	* @dev Set the opening time of the election
	* @param _election index of election to set the time
	* @param _openingTime time to open the election
	*/
	function setOpeningTime(uint _election, uint256 _openingTime) public onlyChairPerson {
		elections[_election].openingTime = _openingTime;
	}

	/**
	* @dev Set the closing time of the election
	* @param _election index of election to set the time
	* @param _closingTime time to close the election
	*/
	function setClosingTime(uint _election, uint256 _closingTime) public onlyChairPerson {
		elections[_election].closingTime = _closingTime;
	}
}