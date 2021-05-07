# CryptoCrowdFund
Deployed on the ropsten test network at [0x63DF514Fa6E6F26379b2C7CC2729cAEE7A820334](https://ropsten.etherscan.io/address/0x63DF514Fa6E6F26379b2C7CC2729cAEE7A820334)

Made with Brownie and Solidity. <3

This is the backend for the [CryptoCrowdFund repo](https://github.com/RyanKeys/CryptoCrowdFund).

### Setup
This should all be done in the same directory this readme is in!
1. Clone this repo and cd into the project folder.
```bash
$ git clone https://github.com/AcidicNic/CryptoCrowdFundContracts
$ cd CryptoCrowdFundContracts
```
2. Ensure you're using the correct node version and install ganache-cli.
```bash
$ nvm install 12
$ nvm use 12 && npm install ganache-cli -g
```
3. Create your Python virtual environment (venv).
```bash
$ python3 -m venv .venv
```
4. Use the venv you just created.
```bash
$ source .venv/bin/activate
```
  - Remember to deactivate your venv ***when you're done*** playing around with this project!
  ```bash
  $ deactivate
  ```
5. Install Brownie in your venv!
```bash
$ pip3 install -r requirements.txt
```
6. Visit [infura.io/](https://infura.io/)
    - Create an account.
    - Create a project.
    - Copy your project ID.
7. Create an environment variable.
```bash
$ export WEB3_INFURA_PROJECT_ID=the-project-id-you-copied
```
8. Add your wallet to Brownie.
  - [Option 1] Create your wallet with MetaMask.
    1. Install the [MetaMask browser extension](https://metamask.io/download.html).
    2. Click on the extension from your toolbar. Import your wallet or create a wallet.
    3. Click on the 3 dots next to your account name > ```Account details``` > ```Export Private Key```. Type in your wallet's password and copy the private key.
    4. Add your wallet to Brownie and give it a name you'll remember. Then paste your wallet's private key.
    ```bash
    $ brownie accounts new some-account-name
    ```
  - [Option 2] Create a new wallet with Brownie.
    1. Generate a new wallet with this command. Give it a name you'll remember and a strong password.
    ```bash
    $ brownie accounts generate some-account-name
    ```
    2. Copy your wallet address that Brownie gives you. It should start with ```0x``` and look something like this: ```0xdfHJKB5JK342g5H4345JKHB245K430H4f3KJ26HB```
9. Use a faucet to request some Ether on a testnet! (We're using Ropsten in this guide)
  - [Option 1] MetaMask
    1. [Visit MetaMask's faucet](https://faucet.metamask.io/).
    2. Open your MetaMask extension, click on ```Ethereum Mainnet``` at the top, and select ```Ropsten Test Network```.
    3. Click on ```request 1 ether from faucet```.
  - [Option 2] Other Wallets
    1. [Visit this Ropsten faucet](https://faucet.ropsten.be/).
    2. Paste your wallet address and click on ```Send me test Ether```.
10. Open ```scripts/crowdfund.py``` in a text editor. Then, replace ```some-account-name``` on line 7 with the name you chose for your wallet when you added it to Brownie.

### What Do I do now?
Here are some things you can do with Brownie!
- `brownie compile` to compile the contracts stored in contracts/
- `brownie test` to run the tests in tests/
- `brownie run crowdfund --network ropsten` runs scripts/crowdfund.py to deploy the contract to the ropsten test network
- Try it out with [OneClickDapp](https://oneclickdapp.com/)
