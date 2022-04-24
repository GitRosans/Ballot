pragma solidity 0.8.7;

// SPDX-License-Identifier: MIT

contract Ballot{

    event Voted(address, voteChoice);
    event Registration(address);
    // We signal to the front that the function have been executed

    address public RegisteredAgent;
    // The RegisteredAgent has permission to add Voters by adding their address


    constructor() {
        RegisteredAgent = msg.sender;
    }
    // Constructor function take the contract deployer as the RegisteredAgent

    enum Registered{
        YES,
        NO
    }

    enum alreadyVOTED{
        YES,
        NO
    }

    enum voteChoice{
        YES,
        NO,
        BLANK_VOTE
    }

    struct Voters{
        voteChoice Choice;
    }

    struct Elector{
        address Address;
        Registered know;
        alreadyVOTED Vote;
    }

    mapping(address => Voters) public voters;

    mapping(address => Elector) public electors;

    function addElector (address _address) public {
        require(msg.sender == RegisteredAgent);
        require(electors[_address].Address != _address);
        electors[_address] = Elector (_address,Registered.YES, alreadyVOTED.NO);
        emit Registration(_address);
    }

    function Vote (voteChoice _vote) public{
        require(msg.sender == electors[msg.sender].Address);
        require(electors[msg.sender].Vote != alreadyVOTED.YES);
        electors[msg.sender] = Elector (msg.sender,Registered.YES, alreadyVOTED.YES);
        voters[msg.sender] = Voters (_vote);
        emit Voted(msg.sender, _vote);
    }

}