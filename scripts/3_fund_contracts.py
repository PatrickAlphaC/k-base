#!/usr/bin/python3
import os
from brownie import KBaseQuestions, accounts, network, interface, config


def main():
    dev = accounts.add(os.getenv(config['wallets']['from_key']))
    # Get the most recent PriceFeed Object
    kbase_questions = KBaseQuestions[len(KBaseQuestions) - 1]
    interface.LinkTokenInterface(config['networks'][network.show_active()]['link_token']).transfer(
        kbase_questions.address, 2000000000000000000, {'from': dev})
    print("Funded {}".format(kbase_questions.address))
