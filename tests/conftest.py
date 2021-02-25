
import pytest
import os

from brownie import network, accounts, config, KBase, Contract, LinkToken


@pytest.fixture()
def token_amount():
    return 10000000000000000000


@pytest.fixture(scope="module")
def get_account():
    if network.show_active() == 'development' or network.show_active() == 'mainnet-fork':
        return accounts[0]
    if network.show_active() in config['networks']:
        dev_account = accounts.add(os.getenv(config['wallets']['from_key']))
        return dev_account
    else:
        pytest.skip('Invalid network/wallet specified ')


@pytest.fixture(scope="module")
def get_kbase_token(get_account, initial_supply):
    if network.show_active() == 'development' or 'fork' in network.show_active():
        kbase_token = KBase.deploy(initial_supply, {'from': get_account})
        return kbase_token
    if network.show_active() in config['networks']:
        return Contract.from_abi(
            "kbase_token", config['networks'][network.show_active()]['kbase_token'], KBase.abi)
    else:
        pytest.skip('Invalid network/link token specified ')


@pytest.fixture(scope="module")
def initial_supply():
    return 1000000000000000000000000


@pytest.fixture(scope="module")
def get_link_token(get_account):
    if network.show_active() == 'development' or 'fork' in network.show_active():
        link_token = LinkToken.deploy({'from': get_account})
        return link_token
    if network.show_active() in config['networks']:
        return Contract.from_abi(
            "link_token", config['networks'][network.show_active()]['link_token'], LinkToken.abi)
    else:
        pytest.skip('Invalid network/link token specified ')
