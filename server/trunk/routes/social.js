/**
 * Created by apple on 16/5/23.
 */



var express = require('express');

var router = express.Router();

var Mongo = require("./../service/Mongo");

router.get('/invite-friend', function(req, res, next){
    var fromUserId = req.query.userId;
    var toUserId = req.query.toUserId;
    Mongo.sendMail(fromUserId, toUserId, {type: "invite"}, function(err){
        if (err != null){
            next(err);
        }else{
            next();
        }
    });
});

router.get('/reply-invite', function(req, res, next){
    var fromUserId = req.query.userId;
    var toUserId = req.query.toUserId;
    var isAgree = Boolean(req.query.isAgree);
    Mongo.sendMail(fromUserId, toUserId, {type: "reply", isAgree: isAgree}, function(err){
        if (err != null){
            next(err);
        }else{
            if(isAgree){
                Mongo.addFriend(toUserId, fromUserId, function(err){
                    next(err);
                });
            }else{
                next();
            }
        }
    });
});

router.get('/get-social', function(req, res, next){
    var userId = req.query.userId;
    Mongo.getFriends(userId, function(err, friends, mails){
        if (err != null){
            next(err);
        }else{
            res.data["friends"] = friends;
            res.data["mails"] = mails;
            next();
        }
    });
});


module.exports = router;