/**
 * Created by zhangguozhi on 16/5/19.
 */

var mongodb = require('mongodb');
var mongoConfig = require("../config/MongoConfig");
var mongoClient = mongodb.MongoClient;
var async = require("async");
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

    async.waterfall([
        function (cb){
            writeDb.collection("User", function(err, userCollection){
                userCollection.insert({_id : userId, password : password, nickName: nickName}, function(err, result){
                    cb(err);
                });
            });
        },
        function (cb) {
            writeDb.collection("Friend", function (err, friendCollection) {
                friendCollection.insert({_id : userId, friendIds : [], mailIds : []}, function(err, result){
                    cb(err);
                });
            });
        },
        function (cb) {
            writeDb.collection("Archive", function (err, archiveCollection) {
                archiveCollection.insert({_id : userId, archiveData : 0, archiveVersion : 0}, function(err, result){
                    cb(err);
                });
            });
        }
    ], function(err){
        callback(err);
    });

};

var userOnline = function(userId){
    async.waterfall([
        function(cb){
            writeDb.collection("Online", function(err, onlineCollection){
                onlineCollection.save({_id : userId, preRequestDate : new Date()}, function(err, result){
                    console.log("user " + userId + " online");
                    cb(null);
                });
            });
        },
        function(cb){
            readDb.collection("Online", function(err, collection){
                collection.find().count(function(err, count){
                    console.log("current online user count: " + count);
                })
            });
        }
    ]);
}

module.exports.userOnline = userOnline;
module.exports.userRigister = userRigister;
module.exports.connect = connect;




