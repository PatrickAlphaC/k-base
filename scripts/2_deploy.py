from brownie import KBase, KBaseQuestions, Contract, accounts, network, config
import os
import logging as log
log.basicConfig(level=log.INFO)

INITIAL_SUPPLY = 1000000000000000000000000


def main():
    dev = accounts.add(os.getenv(config['wallets']['from_key']))
    kbase = ''
    # try:
    kbase = Contract.from_abi(
        "kbase_token", config['networks'][network.show_active()]['kbase_token'], KBase.abi)
    # kbase = KBase[len(KBaseQuestions) - 1]
    # except:
    #     kbase = KBase.deploy(
    #         INITIAL_SUPPLY,
    #         {'from': dev}, publish_source=True
    #     )
    kbase_questions = KBaseQuestions.deploy(
        kbase.address, config['networks'][network.show_active()]['link_token'], {'from': dev}, publish_source=True)
    log.info("KBase deployed at {}. \nKBaseQuestions deployed to {}".format(
        kbase.address, kbase_questions.address))
