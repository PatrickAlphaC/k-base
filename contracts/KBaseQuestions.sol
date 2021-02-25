
// SPDX-License-Identifier: MIT

pragma solidity ^0.6.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract KBaseQuestions is ChainlinkClient {
    uint256 public questionIdCounter;
    mapping(uint256 => Question) public questions;
    mapping(bytes32 => uint256) public requestToQuestions;
    IERC20 public kbaseToken;
    uint256 public answerStakeAmount;
    bytes32 public ipfsJobId;
    address public chainlinkOracle;

    // bytes32 public alphaChainBytes32JobId;
    // address public alphaChainKovanOracle;
    uint256 public fee;

    int256 public STARTING_CHAR_DEFAULT;

    struct Question {
        address asker;
        string CID;
        uint256 answerCounter;
        mapping(uint256 => Answer) answers;
        mapping(bytes32 => bool) firstQuestionRequestIds;
        bool fulfilled; 
    }

    struct Answer {
        address answerer;
        string CID;
        bool accepted;
        uint256 votes;
    }

    constructor(address _kbaseTokenAddress, address _link) public{
        if (_link == address(0)) {
        setPublicChainlinkToken();
        } else {
        setChainlinkToken(_link);
        }
        questionIdCounter = 0;
        kbaseToken = IERC20(_kbaseTokenAddress);
        fee =  0.1 * 10 ** 18; // 0.1 LINK

        // Edit as needed
        ipfsJobId = "28c75899ba0e4750bd813230c796ac2e";
        chainlinkOracle = 0xBCEe35D8DC726Bf19811C1e036783b298F4F059f;

        // alphaChainBytes32JobId = "b7285d4859da4b289c7861db971baf0a";
        // alphaChainKovanOracle = 0xAA1DC356dc4B18f30C347798FD5379F3D77ABC5b;

        // for the ipfs ea
        STARTING_CHAR_DEFAULT = 32;
    }

    function createQuestion(string memory questionText, string memory questionTitle)public returns(uint256 questionId){
        bytes32 requestIdStart = createQuestionFragment(questionText, questionTitle, 0);
        bytes32 requestIdEnd = createQuestionFragment(questionText, questionTitle, STARTING_CHAR_DEFAULT);
        // this is correct for some reason
        Question storage question = questions[questionIdCounter]; 
        questionId = questionIdCounter;
        requestToQuestions[requestIdStart] = questionIdCounter;
        requestToQuestions[requestIdEnd] = questionIdCounter;
        question.firstQuestionRequestIds[requestIdStart] = true;
        question.firstQuestionRequestIds[requestIdEnd] = false;
        question.asker = msg.sender;
        questionIdCounter = questionIdCounter + 1;
        return questionId;
    }

    function createQuestionFragment(string memory questionText, string memory questionTitle, int256 starting_char) internal returns (bytes32 requestId){
        Chainlink.Request memory request_fragment = buildChainlinkRequest(ipfsJobId, address(this), this.fulfillQuestionAskFragment.selector);
        // request.add("get", "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETH&tsyms=USD");
        request_fragment.add("text_for_file", questionText);
        request_fragment.add("text_for_file_name", questionTitle);
        request_fragment.addInt("starting_char", starting_char);
        return sendChainlinkRequestTo(chainlinkOracle, request_fragment, fee);
    }

    function createAnswer(string memory answerText, string memory answerTitle) public returns (bytes32 requestId){
        Chainlink.Request memory request = buildChainlinkRequest(ipfsJobId, address(this), this.fulfillAnswerQuestion.selector);
        request.add("text_for_file", answerText);
        request.add("text_for_file_name", answerTitle);
        return sendChainlinkRequestTo(chainlinkOracle, request, fee);
    }

    function fulfillQuestionAskFragment(string memory ipfsCIDQuestion, bytes32 requestId) public recordChainlinkFulfillment(requestId) returns (bool){
        uint256 questionId = requestToQuestions[requestId];
        uint256 questionByteSize = bytes(questions[questionId].CID).length;
        if(questions[questionId].firstQuestionRequestIds[requestId] == true && questionByteSize > 0){
            string memory tmp = questions[questionId].CID;
            questions[questionId].CID = string(abi.encodePacked(ipfsCIDQuestion, tmp));
            questions[questionId].fulfilled = true;
            return true;
        }
        if (questions[questionId].firstQuestionRequestIds[requestId] == true && questionByteSize == 0){
            questions[questionId].CID = ipfsCIDQuestion;
            return true; 
        }
        if(questions[questionId].firstQuestionRequestIds[requestId] == false){
            questions[questionId].CID = string(abi.encodePacked(questions[questionId].CID, ipfsCIDQuestion));
            questions[questionId].fulfilled = true;
            return true;
        }
        return false;
    }

    // function fulfillQuestionAsk(string memory ipfsCIDQuestion, bytes32 requestId) public {
    //     question.CID = ipfsCIDQuestion;
    //     question.answerCounter = 0;
    //     // kbaseToken.transfer(msg.sender, 1000000000000000000);
    // }

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

    function bytes32ToString(bytes32 _bytes32) public pure returns (string memory) {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }
}
