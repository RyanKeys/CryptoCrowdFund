const express = require("express");
const expressHandlebars = require("express-handlebars");
const path = require("path");
const Web3 = require("web3");

const app = express();
app.use(express.static("client"));
app.engine("handlebars", expressHandlebars({ defaultLayout: "main" }));
app.set("view engine", "handlebars");
const port = 3000;

const rpcURL = "https://rinkeby.infura.io/v3/fd78f6f784a64fe1a20865081c28a049";
const web3 = new Web3(rpcURL);
const address = "0x60680e1c9de55a4e65653b4b56ea93791e7fd64f";

app.get("/", (req, res) => {
  res.render("index");
});

app.get("/profile", (req, res) => {
  web3.eth.getBalance(address, (err, wei) => {
    balance = web3.utils.fromWei(wei, "ether");
    res.render("profile", { balance: balance });
  });
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
