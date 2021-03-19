const express = require("express");
const expressHandlebars = require("express-handlebars");
const Web3 = require("web3");
const path = require("path");
const app = express();
app.engine("handlebars", expressHandlebars({ defaultLayout: "main" }));
app.set("view engine", "handlebars");
app.use("/static", express.static("public"));
const port = 3000;

// Allows access to the desired network. Currently pointing to the Rinkeby test network.
const rpcURL = "https://rinkeby.infura.io/v3/fd78f6f784a64fe1a20865081c28a049";
const web3 = new Web3(rpcURL);
// Eventually this will lead to the address of our smart contract.
const address = "0x60680e1c9de55a4e65653b4b56ea93791e7fd64f";

app.get("/", (req, res) => {
  res.render("index");
});

app.get("/listings", (req, res) => {
  if (req.query.new !== undefined) {
    res.render("listings", { context: "new" });
  } else if (req.query.popular !== undefined) {
    res.render("listings", { context: "popular" });
  } else {
    res.render("listings");
  }
});

app.get("/getting-started", (req, res) => {
  res.render("getting-started");
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
