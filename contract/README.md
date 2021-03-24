# CryptoCrowdFund
Deployed on the ropsten test network at [0xD878275af39A861ebc454B12C2bf81b1fA360b90](https://ropsten.etherscan.io/address/0xD878275af39A861ebc454B12C2bf81b1fA360b90)


### Setup
This should all be done in the same directory this readme is in!
1. Create your Python virtual environment (venv).
```bash
python3 -m venv .venv
```
1. Use the venv you just created.
```bash
source .venv/bin/activate
```
1. Install Brownie in your venv!
```bash
pip3 install eth-brownie
```
1. Ensure you're using the correct node version and install ganache-cli.
```bash
nvm install 12
nvm use 12 && npm install ganache-cli -g
```
1. Visit [infura.io/](https://infura.io/)
    - Create an account.
    - Create a project.
    - Copy your project ID.
1. Create an environment variable.
```bash
export WEB3_INFURA_PROJECT_ID=the-project-id-you-copied
```
1. Add your eth wallet to brownie.
```bash
brownie accounts --help
```


### What Do I do now?
Here are some things you can do with Brownie!
- `brownie compile` to compile the contracts stored in contracts/
- `brownie test` to run the tests in tests/
- `brownie run crowdfund --network ropsten` runs scripts/crowdfund.py to deploy the contract to the ropsten test network
