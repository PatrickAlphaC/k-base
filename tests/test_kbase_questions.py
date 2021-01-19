import pytest
import os
from brownie import KBaseQuestions, KBase, accounts, network, config


def test_kbase_questions():
    dev_account = accounts.add(os.getenv(config['wallets']['from_key']))
    kbase = KBase.deploy(100000000000000000000, {'from': dev_account})
    kbase_questions = KBaseQuestions.deploy(
        kbase.address, {'from': dev_account})
    assert kbase_questions is not None

    kbase_questions.askQuestion(
        "Qmc4z16XfHh9Bt9GWja1dVYvqKiN42gD8N4joqSN7b6W1a")
    assert kbase_questions.questions(0)['asker'] == dev_account
    assert kbase_questions.questions(
        0)['CID'] == "Qmc4z16XfHh9Bt9GWja1dVYvqKiN42gD8N4joqSN7b6W1a"
