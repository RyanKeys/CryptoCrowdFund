#!/usr/bin/python3

from brownie import CrowdFund, CrowdFundFactory, accounts


def main():
    account = accounts.load('some-account-name')
    return CrowdFund.deploy({'from': account})
