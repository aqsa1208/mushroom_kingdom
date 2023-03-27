var express = require("express");
var path = require("path");
var http = require('http');
var app = express();
var server = http.createServer(app);

server.listen(5001);
const portNumber = server.address().port;
console.log(`port is open on ${portNumber}`);

app.use('/public', express.static(__dirname + "/public"));

app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname + "/Loading.html"));
})

app.get("/index.html", (req, res) => {
    res.sendFile(path.join(__dirname + "/index.html"));
})

app.get("/modal_test.html", (req, res) => {
    res.sendFile(path.join(__dirname + "/modal_test.html"));
})

app.get("/pair.html", (req, res) => {
    res.sendFile(path.join(__dirname + "/pair.html"));
})

app.get("/Translate.html", (req, res) => {
    res.sendFile(path.join(__dirname + "/Translate.html"));
})
