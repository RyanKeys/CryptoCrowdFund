#!/usr/bin/python3

from brownie import CrowdFund, CrowdFundFactory, accounts


def main():
    account = accounts.load('metamask')
    return CrowdFund.deploy({'from': account})
