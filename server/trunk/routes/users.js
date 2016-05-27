var express = require('express');

var router = express.Router();


/* GET users listing. */
router.get('/', function(req, res, next) {
    res.send('respond with a resource');
});



var Mongo = require("./../service/Mongo");


router.get("/register", function(req, res, next){
    Mongo.userRigister(req.query.userId, req.query.password, req.query.nickName, function(err){
        next(err);
    });
});


router.get("/login", function(req, res, next){
    Mongo.userLogin(req.query.userId, req.query.password, function(err, data){
        if (err != null){
            next(err);
        }else{
            res.data = data;
            next();
        }
    });
});





module.exports = router;
