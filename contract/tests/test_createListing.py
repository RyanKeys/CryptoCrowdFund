import pytest
from brownie import CrowdFund, CrowdFundFactory, accounts, reverts

@pytest.fixture
def token():
    return CrowdFund.deploy({'from': accounts[0]})

def test_createListing_NewListing_event(token):
    tx = token.createListing(100, 10, {'from': accounts[2]})
    assert tx.events[0]['owner'] == accounts[2]
    assert tx.events[0]['listingId'] == 0
    assert tx.events[0]['goal'] == 100

def test_createListing_invalid_length(token):
    with reverts("Invalid _lengthSeconds"):
        token.createListing(100, 31536001, {'from': accounts[2]})

def test_createListing_invalid_goal(token):
    with reverts("Invalid _goal"):
        token.createListing(0, 10, {'from': accounts[2]})
