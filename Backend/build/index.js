"use strict";

var express = require("express");
var bodyParser = require('body-parser');
var initWebRoutes = require("./route/route");
var connectDB = require('./config/connectDB');
var cors = require('cors');
var cookieParser = require('cookie-parser');
var socketIo = require('socket.io');
var http = require('http');
require('dotenv').config();
var app = express();
var server = http.createServer(app);
var io = socketIo(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});
app.use(cookieParser());
app.use(bodyParser.urlencoded({
  extended: false
}));
app.use(bodyParser.json());
var corsOptions = {
  origin: "http://137.184.250.129:80",
  credentials: true
};
app.use(cors(corsOptions));

// app.use(function (req, res, next) {
//     // Website you wish to allow to connect , this include http not only port of FrontEnd
//     res.setHeader('Access-Control-Allow-Origin',"http://localhost:3000");

//     // Request methods you wish to allow
//     res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

//     // Request headers you wish to allow
//     res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type','text/plain');

//     // Set to true if you need the website to include cookies in the requests sent
//     // to the API (e.g. in case you use sessions)
//     res.setHeader('Access-Control-Allow-Credentials', true);

//     // Pass to next layer of middleware
//     next();
// });
var activeUsers = [];
io.on("connection", function (socket) {
  console.log("New client connected: " + socket.id);
  socket.on('new-user-add', function (newUserId) {
    if (!activeUsers.some(function (user) {
      return user.userId === newUserId;
    })) {
      activeUsers.push({
        userId: newUserId,
        socketId: socket.id
      });
      console.log('new user add', activeUsers);
    }
    io.emit("get-users", activeUsers);
  });
  socket.on("sendMsgClient", function (data) {
    var user = activeUsers.find(function (user) {
      return user.userId == data.receiverId;
    });
    console.log(activeUsers);
    console.log(user);
    if (user) {
      io.to(user.socketId).emit('receive-message', data);
      console.log('ok', user.socketId);
    }
  });
  socket.on("disconnect", function () {
    console.log("Client disconnected");
    activeUsers = activeUsers.filter(function (user) {
      return user.socketId !== socket.id;
    });
    io.emit("get-users", activeUsers);
  });
});
initWebRoutes(app);
connectDB();
server.listen(5000, function () {
  console.log("Server running on 5000");
});