// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DAO {
    struct Proposal {
        uint id;
        string description;
        uint votesFor;
        uint votesAgainst;
        uint deadline;
        bool executed;
        address proposer;
    }

    mapping(uint => Proposal) public proposals;
    uint public proposalCount;
    mapping(uint => mapping(address => bool)) public hasVoted;

    IERC20 public daoToken;
    uint public constant VOTING_PERIOD = 3 days;

    event ProposalCreated(uint id, string description, address proposer);
    event Voted(uint id, address voter, bool support);
    event ProposalExecuted(uint id, bool success);

    constructor(address tokenAddress) {
        daoToken = IERC20(tokenAddress);
    }

    function createProposal(string memory _description) external {
        proposalCount++;
        proposals[proposalCount] = Proposal(
            proposalCount,
            _description,
            0,
            0,
            block.timestamp + VOTING_PERIOD,
            false,
            msg.sender
        );
        emit ProposalCreated(proposalCount, _description, msg.sender);
    }

    function vote(uint _proposalId, bool _support) external {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp < proposal.deadline, "Voting period ended");
        require(!hasVoted[_proposalId][msg.sender], "Already voted");

        hasVoted[_proposalId][msg.sender] = true;

        uint voterWeight = daoToken.balanceOf(msg.sender);

        if (_support) {
            proposal.votesFor += voterWeight;
        } else {
            proposal.votesAgainst += voterWeight;
        }

        emit Voted(_proposalId, msg.sender, _support);
    }

    function executeProposal(uint _proposalId) external {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp >= proposal.deadline, "Voting still in progress");
        require(!proposal.executed, "Proposal already executed");

        proposal.executed = true;
        bool success = proposal.votesFor > proposal.votesAgainst;

        emit ProposalExecuted(_proposalId, success);
    }
}
