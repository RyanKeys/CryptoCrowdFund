# CryptoCrowdFund
Deployed on the ropsten test network at [0x63DF514Fa6E6F26379b2C7CC2729cAEE7A820334](https://ropsten.etherscan.io/address/0x63DF514Fa6E6F26379b2C7CC2729cAEE7A820334)


### Setup
This should all be done in the same directory this readme is in!
1. Create your Python virtual environment (venv).
```bash
python3 -m venv .venv
```
2. Use the venv you just created.
```bash
source .venv/bin/activate
```
3. Install Brownie in your venv!
```bash
pip3 install eth-brownie
```
4. Ensure you're using the correct node version and install ganache-cli.
```bash
nvm install 12
nvm use 12 && npm install ganache-cli -g
```
5. Visit [infura.io/](https://infura.io/)
    - Create an account.
    - Create a project.
    - Copy your project ID.
6. Create an environment variable.
```bash
export WEB3_INFURA_PROJECT_ID=the-project-id-you-copied
```
7. Go copy your wallet's private key, then add your wallet to Brownie.
```bash
brownie accounts new some-account-name
```
- OR... Create a new wallet with Brownie, if you don't already have one.
```bash
brownie accounts generate some-account-name
```


### What Do I do now?
Here are some things you can do with Brownie!
- `brownie compile` to compile the contracts stored in contracts/
- `brownie test` to run the tests in tests/
- `brownie run crowdfund --network ropsten` runs scripts/crowdfund.py to deploy the contract to the ropsten test network
