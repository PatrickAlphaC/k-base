
// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract KBaseQuestions is ChainlinkClient {
    uint256 public questionIdCounter;
    mapping(uint256 => Question) public questions;
    IERC20 public kbaseToken;
    uint256 public answerStakeAmount;

    bytes32 public ipfsJobId;
    address public chainlinkOracle;
    uint256 public fee;

    struct Question {
        address asker;
        string CID;
        uint256 answerCounter;
        mapping(uint256 => Answer) answers;
    }

    struct Answer {
        address answerer;
        string CID;
        bool accepted;
        uint256 votes;
    }

    constructor(address _kbaseTokenAddress) public{
        questionIdCounter = 0;
        kbaseToken = IERC20(_kbaseTokenAddress);
        fee =  0.1 * 10 ** 18; // 0.1 LINK

        // Edit as needed
        ipfsJobId = "28c75899ba0e4750bd813230c796ac2e";
        chainlinkOracle = 0xBCEe35D8DC726Bf19811C1e036783b298F4F059f;
    }

    function createQuestion(string memory questionText, string memory questionTitle) public returns (bytes32 requestId){
        Chainlink.Request memory request = buildChainlinkRequest(ipfsJobId, address(this), this.fulfillQuestionAsk.selector);
        // request.add("get", "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETH&tsyms=USD");
        request.add("text_for_file", questionText);
        request.add("text_for_file_name", questionTitle);
        request.add("copyPath", "result");
        return sendChainlinkRequestTo(chainlinkOracle, request, fee);
    }

    function createAnswer(string memory answerText, string memory answerTitle) public returns (bytes32 requestId){
        Chainlink.Request memory request = buildChainlinkRequest(ipfsJobId, address(this), this.fulfillAnswerQuestion.selector);
        // request.add("get", "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETH&tsyms=USD");
        request.add("text_for_file", answerText);
        request.add("text_for_file_name", answerTitle);
        return sendChainlinkRequestTo(chainlinkOracle, request, fee);
    }

    function fulfillQuestionAsk(string memory ipfsCIDQuestion, bytes32 requestId) public {
        Question storage question = questions[questionIdCounter];
        question.asker = msg.sender;
        question.CID = ipfsCIDQuestion;
        question.answerCounter = 0;
        questionIdCounter = questionIdCounter + 1;
        // kbaseToken.transfer(msg.sender, 1000000000000000000);
    }

    function fulfillAnswerQuestion(string memory ipfsCIDAnswer, uint256 questionId) public {
        // Add new answer
        Answer storage answer = questions[questionId].answers[questions[questionId].answerCounter];
        answer.answerer = msg.sender;
        answer.CID = ipfsCIDAnswer;
        answer.accepted = false;
        answer.votes = 0;
        // update answer counter
        questions[questionId].answerCounter = questions[questionId].answerCounter + 1;
        kbaseToken.transfer(msg.sender, 1000000000000000000);
    }

    function acceptAnswer(uint256 questionId, uint256 answerId) public onlyQuestionAsker(questionId){
        questions[questionId].answers[answerId].accepted = true;
        kbaseToken.transfer(questions[questionId].answers[answerId].answerer, 1000000000000000000);
    }

    function getAnswerCID(uint256 questionId, uint256 answerId) public view returns (string memory){
        string memory CID = questions[questionId].answers[answerId].CID;
        return CID;
    }
    function getAnswerStatus(uint256 questionId, uint256 answerId) public view returns (bool){
        bool accepted = questions[questionId].answers[answerId].accepted;
        return accepted;
    }

    function getQuestionAsker(uint256 questionId) public view returns (address){
        return questions[questionId].asker;
    }

    function getQuestionCID(uint256 questionId) public view returns (string memory){
        return questions[questionId].CID;
    }
    


    modifier onlyQuestionAsker(uint256 questionId) {
        require(
            msg.sender == questions[questionId].asker,
            "Only the question asker can call this function."
        );
        _;
    }
}
