import pytest
from brownie import CrowdFund, CrowdFundFactory, accounts, reverts

@pytest.fixture
def token():
    return CrowdFund.deploy({'from': accounts[0]})

def test_submitDonation_balance(token):
    token.createListing(100, 10, {'from': accounts[2]})
    token.createListing(100, 10, {'from': accounts[2]})
    assert token.balance() == 0
    token.submitDonation(0, {'from': accounts[0], 'value': 50})
    assert token.balance() == 50
    token.submitDonation(1, {'from': accounts[1], 'value': 50})
    assert token.balance() == 100
    token.submitDonation(0, {'from': accounts[3], 'value': 100})
    assert token.balance() == 200
    token.submitDonation(1, {'from': accounts[3], 'value': 100})
    assert token.balance() == 300

def test_submitDonation_from_owner(token):
    token.createListing(100, 10, {'from': accounts[2]})
    with reverts("This is your listing."):
        token.submitDonation(0, {'from': accounts[2], 'value': 100})

def test_submitDonation_after_finished(token):
    token.createListing(100, 0, {'from': accounts[2]})
    with reverts("This listing is finished."):
        token.submitDonation(0, {'from': accounts[1], 'value': 100})

def test_submitDonation_NewDonation_event(token):
    token.createListing(100, 10, {'from': accounts[2]})
    tx = token.submitDonation(0, {'from': accounts[1], 'value': 100})
    assert tx.events[0]['listingId'] == 0
    assert tx.events[0]['donation'] == 100
    assert tx.events[0]['donor'] == accounts[1]
