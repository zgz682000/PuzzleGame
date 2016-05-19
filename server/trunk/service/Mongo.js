/**
 * Created by zhangguozhi on 16/5/19.
 */

var mongodb = require('mongodb');
var mongoConfig = require("../config/MongoConfig");
var mongoClient = mongodb.MongoClient;

var getMongoUrlByConfig = function (config){
    return "mongodb://" + config.username + ":" + config.password + "@" + config.host + ":" + config.port + "/PuzzleGame";
};

var readDb = null;
var writeDb = null;

var connect = function(readCb, writeCb){
    var readUrl = getMongoUrlByConfig(mongoConfig.mongo_1);
    mongoClient.connect(readUrl, function(err, db) {
        readDb = db;
        readCb(err, readDb)
    });

    var writeUrl = getMongoUrlByConfig(mongoConfig.mongo_2);
    mongoClient.connect(writeUrl, function(err, db){
        writeDb = db;
        writeCb(err, writeDb);
    });
};


var userRigister = function(userId, password, nickName, callback){
    writeDb.collection("User", function(err, userCollection){
        userCollection.insert({_id : userId, password : password, nickName: nickName}, function(err, result){
            callback(err);
        });
    });
};

var userOnline = function(userId){
    writeDb.collection("Online", function(err, onlineCollection){
        onlineCollection.save({_id : userId, preRequestDate : new Date()}, function(err, result){
            console.log("user " + userId + " online");
        });
    });
}

module.exports.userOnline = userOnline;
module.exports.userRigister = userRigister;
module.exports.connect = connect;




