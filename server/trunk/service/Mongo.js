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
                userCollection.insert({_id : userId, password : password, nickName: nickName, lastLoginDate : new Date()}, function(err, result){
                    cb(err);
                });
            });
        },
        function (cb) {
            writeDb.collection("Social", function (err, friendCollection) {
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

var userLogin = function(userId, password, callback){
    async.waterfall([
        function (cb) {
            readDb.collection("User", function (err, collection) {
                if (err != null){
                    return cb(err);
                }
                collection.findOne({_id : userId}, function(err, result){
                    if (err != null){
                        return cb(err);
                    }
                    if (result.password != password){
                        return cb("user password err");
                    }else{
                        return cb(null, {user : result});
                    }
                });
            });
        },
        function (data, cb) {
            getFriends(userId, function(err, friends, mails){
                if (err != null){
                    return cb(err);
                }
                data["friends"] = friends;
                data["mails"] = mails;
                cb(null, data);
            });
        },

        function (data, cb){
            readDb.collection("Archive", function(err, collection){
                if (err != null){
                    return cb(err);
                }
                collection.findOne({_id : userId}, function(err, result){
                    if (err != null){
                        return cb(err);
                    }
                    data["archive"] = result;
                    cb(null, data);
                });
            });
        },

        function(data, cb){
            writeDb.collection("User", function(err, collection){
                if (err != null){
                    return cb(err);
                }
                collection.update({_id : userId}, {$set : {lastLoginDate : new Date()}}, function(err, result){
                    if (err != null){
                        return cb(err);
                    }
                    cb(null, data);
                });
            });
        }
    ], function (err,data) {
        callback(err, data);
    });
}

var getFriends = function(userId, callback){
    readDb.collection("Social", function(err, collection){
        if (err != null){
            return callback(err);
        }
        collection.findOne({_id : userId}, function(err, result){
            if (err != null){
                return cb(err);
            }
            async.waterfall(
                [
                    function(cb){
                        async.map(result.friendIds, function(friendId, cb){
                            readDb.collection("User", function (err, collection) {
                                if (err != null){
                                    return cb(err);
                                }
                                collection.findOne({_id : userId}, function(err, user){
                                    if (err != null){
                                        return cb(err);
                                    }
                                    delete user.password;
                                    cb(null, user);
                                });
                            });
                        }, cb);
                    },

                    function(friends, cb){
                        async.map(result.mailIds, function(mailId, cb){
                            readDb.collection("Mail", function (err, collection) {
                                if (err != null){
                                    return cb(err);
                                }
                                collection.findOne({_id : mailId}, function(err, mail){
                                    if (err != null){
                                        return cb(err);
                                    }
                                    delete user.password;
                                    cb(null, mail);
                                });
                            });
                        }, function(err, mails){
                            cb(err, friends, mails);
                        });
                    }
                ], callback
            );
        });
    });
}

var sendMail = function(fromUserId, toUserId, mailObj, callback){
    var mail = {fromUserId : fromUserId, toUserId : toUserId, content : mailObj, date : new Date()};
    writeDb.collection("Mail", function(err, mailCollection){
        mailCollection.insert(mail, function(err, result){
            if (err != null){
                return callback(err);
            }
            writeDb.collection("Social", function(err, friendCollection){
                if(err != null){
                    return callback(err);
                }
                friendCollection.updateOne({_id : toUserId}, {$push : {mailIds : result.insertedIds[0]}}, function(err, result){
                    if(err != null){
                        return callback(err);
                    }
                    callback(null);
                });
            });
        });
    });
}

var addFriend = function(userId, friendId, callback){
    async.waterfall([
        function (cb) {
            writeDb.collection("User", function(err, userCollection){
                if (err != null){
                    return cb(err);
                }
                userCollection.updateOne({_id : userId}, {$push : {friendIds : friendId}}, function(err, result){
                     cb(err);
                });
            });
        },
        function(cb){
            writeDb.collection("User", function(err, userCollection){
                if (err != null){
                    return cb(err);
                }
                userCollection.updateOne({_id : friendId}, {$push : {friendIds : userId}}, function(err, result){
                    cb(err);
                });
            });
        }
    ],callback);
}

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

module.exports.addFriend = addFriend;
module.exports.sendMail = sendMail;
module.exports.getFriends = getFriends;
module.exports.userLogin = userLogin;
module.exports.userOnline = userOnline;
module.exports.userRigister = userRigister;
module.exports.connect = connect;




