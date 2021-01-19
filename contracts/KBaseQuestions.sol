
// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract KBaseQuestions {
    Question[] public questions;
    IERC20 public kbaseToken;

    struct Question {
        address asker;
        string CID;
    }

    constructor(address _kbaseTokenAddress) public{
        kbaseToken = IERC20(_kbaseTokenAddress);
    }

    function askQuestion(string memory ipfsCID) public {
        questions.push(Question(msg.sender, ipfsCID));
    }
}
