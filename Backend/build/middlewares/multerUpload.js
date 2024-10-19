"use strict";

var Multer = require("multer");
var storage = Multer.memoryStorage();
var upload = Multer({
  storage: storage
});
module.exports = upload;