import pytest
from time import sleep
from brownie import CrowdFund, CrowdFundFactory, accounts, reverts

@pytest.fixture
def token():
    return CrowdFund.deploy({'from': accounts[0]})

def test_endListing_attempted_too_soon(token):
    token.createListing(100, 2, {'from': accounts[2]})
    with reverts("This listing is still active."):
        token.listingEnd(0, {'from': accounts[2]})

def test_endListing_goal_met(token):
    owner_balance_starting = accounts[2].balance()
    donor_balance_starting = accounts[3].balance()
    token.createListing(100, 2, {'from': accounts[2]})
    token.submitDonation(0, {'from': accounts[3], 'value': 100})
    assert accounts[2].balance() == owner_balance_starting
    assert accounts[3].balance() == donor_balance_starting - 100
    assert token.balance() == 100

    sleep(2)
    token.listingEnd(0, {'from': accounts[2]})

    assert accounts[2].balance() == owner_balance_starting + 100
    assert accounts[3].balance() == donor_balance_starting - 100
    assert token.balance() == 0

def test_endListing_goal_not_met(token):
    owner_balance_starting = accounts[2].balance()
    donor_balance_starting = accounts[3].balance()
    token.createListing(100, 2, {'from': accounts[2]})
    token.submitDonation(0, {'from': accounts[3], 'value': 99})

    assert accounts[3].balance() == donor_balance_starting - 99
    assert token.balance() == 99

    sleep(2)
    token.listingEnd(0, {'from': accounts[2]})

    assert token.balance() == 0
    assert accounts[2].balance() == owner_balance_starting
    assert accounts[3].balance() == donor_balance_starting

def test_endListing_AnnounceResults_event_no_donations(token):
    token.createListing(100, 0, {'from': accounts[2]})
    tx = token.listingEnd(0, {'from': accounts[2]})
    assert tx.events[0]['listingId'] == 0
    assert tx.events[0]['totalDonations'] == 0
    assert tx.events[0]['result'] == "NO DONATIONS"

def test_endListing_AnnounceResults_event_refunded(token):
    token.createListing(100, 1, {'from': accounts[2]})
    token.submitDonation(0, {'from': accounts[3], 'value': 99})
    sleep(1)
    tx = token.listingEnd(0, {'from': accounts[2]})
    assert tx.events[0]['listingId'] == 0
    assert tx.events[0]['totalDonations'] == 99
    assert tx.events[0]['result'] == "REFUNDED"

def test_endListing_AnnounceResults_event_goal_met(token):
    token.createListing(100, 1, {'from': accounts[2]})
    token.submitDonation(0, {'from': accounts[3], 'value': 100})
    sleep(1)
    tx = token.listingEnd(0, {'from': accounts[2]})
    assert tx.events[0]['listingId'] == 0
    assert tx.events[0]['totalDonations'] == 100
    assert tx.events[0]['result'] == "GOAL MET"
