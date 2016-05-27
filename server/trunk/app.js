var express = require('express');
var path = require('path');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var assert = require("assert");

var routes = require('./routes/index');
var users = require('./routes/users');
var social = require('./routes/social')
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.enable("trust proxy");

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/users', users);
app.use('/social', social);

var UserOnline = require("./middlewares/UserOnline");
app.use(UserOnline);

var JsonRespone = require("./middlewares/JsonResponse")
app.use(JsonRespone.successHandler);
app.use(JsonRespone.errerHandler);



// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


var Mongo = require("./service/Mongo");

Mongo.connect(function (err, readDb) {
    assert.equal(null, err, err.message);
    console.log("mongo_read ready");
}, function(err, writeDb){
    assert.equal(null, err, err.message);
    console.log("mongo_write ready");
});

module.exports = app;
