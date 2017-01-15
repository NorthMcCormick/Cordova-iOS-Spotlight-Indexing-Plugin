var exec = require('cordova/exec');

var _API_CLASS = 'NorthPluginSpotlight';

function execute(method, params) {
    params = !params ? [] : params;

    return new Promise(function (resolve, reject) {
        exec(function (res) {
            resolve(res);
        }, function (err) {
            reject(err);
        }, _API_CLASS, method, params);
    });
}

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, _API_CLASS, "coolMethod", [arg0]);
};

exports.echo = function(arg0, success, error) {
  exec(success, error, _API_CLASS, "echo", [arg0]);
};

exports.indexItem = function(arg0) {
	return execute('indexItem', [arg0])
};

exports.removeIndexedItem = function(arg0) {
	return execute('removeIndexedItem', [arg0])
};

exports.echojs = function(arg0, success, error) {
  if (arg0 && typeof(arg0) === 'string' && arg0.length > 0) {
    success(arg0);
  } else {
    error('Empty message!');
  }
};