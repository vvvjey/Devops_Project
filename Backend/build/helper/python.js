"use strict";

var _require = require('node:child_process'),
  spawn = _require.spawn;
function runPythonScript() {
  return new Promise(function (resolve, reject) {
    var pythonProcess = spawn('python', ["./src/helper/popularityProdRecom.py"]);
    var data = '';
    var error = '';
    pythonProcess.stdout.on('data', function (chunk) {
      data += chunk.toString();
    });
    pythonProcess.stderr.on('data', function (chunk) {
      error += chunk.toString();
    });
    pythonProcess.on('close', function (code) {
      if (code !== 0) {
        reject(new Error("Python script exited with code ".concat(code, ": ").concat(error)));
      } else {
        try {
          var result = JSON.parse(data);
          resolve(result);
        } catch (e) {
          reject(new Error("Failed to parse JSON: ".concat(e.message)));
        }
      }
    });
  });
}
module.exports = {
  runPythonScript: runPythonScript
};