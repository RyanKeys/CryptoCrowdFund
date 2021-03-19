function metaMaskLogin() {
  if (window.ethereum) {
    window.web3 = new Web3(window.ethereum);
    try {
      // ask user for permission
      ethereum.enable();
      provider = new ethers.providers.Web3Provider(window.ethereum);
      // The Metamask plugin also allows signing transactions to
      // send ether and pay to change state within the blockchain.
      // For this, you need the account signer...
      signer = provider.getSigner();
      loginHandler(provider, signer);
      // user approved permission
    } catch (error) {
      // user rejected permission
      console.log("user rejected permission");
    } finally {
    }
  } else if (window.web3) {
    window.web3 = new Web3(window.web3.currentProvider);
    // no need to ask for permission
  } else {
    window.alert(
      "Non-Ethereum browser detected. You should consider trying MetaMask!"
    );
  }
}

function loginHandler(provider, signer) {
  signer.getAddress().then((response) => {
    console.log(response);
    $("#nav-content").empty();
    $("#sidenav-content").empty();

    provider.getBalance(response).then((res) => {
      var balance = ethers.utils.formatEther(res);
      $("#nav-content").append(
        `<div style='overflow: hidden;
        width:50%; background-color: #1b2838; border-radius: 5px;'><a href="https://etherscan.io/address/${response}">Account:${response}</a></div>`
      );
      $("#sidenav-content").append(
        `<div class='container' style='overflow: hidden; line-height: initial; margin-top: 1em;'><a style="color: #c7d5e0"        href="https://etherscan.io/address/${response}">Your Account: ${response}</a></div>`
      );
    });
  });
}
metaMaskLogin();
