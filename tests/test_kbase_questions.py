import pytest
from brownie import KBaseQuestions, KBase


def test_kbase_questions(get_account, initial_supply, get_kbase_token):
    kbase_questions = KBaseQuestions.deploy(
        get_kbase_token.address, {'from': get_account})
    assert kbase_questions is not None
    kbase_questions.askQuestion(
        "Qmc4z16XfHh9Bt9GWja1dVYvqKiN42gD8N4joqSN7b6W1a")
    assert kbase_questions.getQuestionAsker.call(0) == get_account
    assert kbase_questions.getQuestionCID.call(
        0) == "Qmc4z16XfHh9Bt9GWja1dVYvqKiN42gD8N4joqSN7b6W1a"


@pytest.fixture()
def test_kbase_answer_question(get_account, get_kbase_token, token_amount):
    kbase_questions = KBaseQuestions.deploy(
        get_kbase_token.address, {'from': get_account})
    get_kbase_token.transfer(kbase_questions.address,
                             token_amount, {'from': get_account})
    kbase_questions.askQuestion(
        "Qmc4z16XfHh9Bt9GWja1dVYvqKiN42gD8N4joqSN7b6W1a")
    kbase_questions.answerQuestion(
        "Qmc2gHt642hnf27iptGbbrEG94vwGnVH48KyeMtjCF5icH", 0)
    assert kbase_questions.questionIdCounter() == 1
    assert kbase_questions.getAnswerCID(
        0, 0) == "Qmc2gHt642hnf27iptGbbrEG94vwGnVH48KyeMtjCF5icH"
    return kbase_questions


def test_kbase_accept_answer_question(get_account, get_kbase_token, token_amount, test_kbase_answer_question):
    kbase_questions = test_kbase_answer_question
    assert kbase_questions.getAnswerStatus(0, 0) is False
    kbase_questions.acceptAnswer(0, 0)
    assert kbase_questions.getAnswerStatus(0, 0) is True


def test_only_question_asker_modifier():
    pass
