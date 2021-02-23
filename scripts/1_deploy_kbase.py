from brownie import KBase, KBaseQuestions, accounts, network, config
import os
import logging as log
log.basicConfig(level=log.INFO)

INITIAL_SUPPLY = 1000000000000000000000000


def main():
    dev = accounts.add(os.getenv(config['wallets']['from_key']))
    KBase.deploy(
        INITIAL_SUPPLY, config['networks'][network.show_active()
                                           ]['link_token'],
        {'from': dev}, publish_source=True
    )
