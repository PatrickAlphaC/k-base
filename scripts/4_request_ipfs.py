from brownie import KBase, KBaseQuestions, Contract, accounts, network, config
import os
import logging as log
log.basicConfig(level=log.INFO)

INITIAL_SUPPLY = 1000000000000000000000000

QUESTION_TEXT = "What is an apple? "
QUESTION_TITLE = "Apple?"


def main():
    dev = accounts.add(os.getenv(config['wallets']['from_key']))
    kbase_questions = KBaseQuestions[len(KBaseQuestions) - 1]
    kbase_questions.createQuestion(QUESTION_TEXT, QUESTION_TITLE,
                                   {'from': dev})
    print(kbase_questions.address)
