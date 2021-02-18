from brownie import KBase, KBaseQuestions, accounts, network, config
import os
import logging as log
log.basicConfig(level=log.INFO)

INITIAL_SUPPLY = 1000000000000000000000000


def main():
    dev = accounts.add(os.getenv(config['wallets']['from_key']))
    kbase = KBase.deploy(
        INITIAL_SUPPLY,
        {'from': dev}, publish_source=True
    )
    kbase_questions = KBaseQuestions.deploy(
        kbase.address, {'from': dev}, publish_source=True)
    log.info("KBase deployed to {}. \nKBaseQuestions deployed to {}".format(
        kbase.address, kbase_questions.address))
