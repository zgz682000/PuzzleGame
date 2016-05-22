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
      if (err == null) {
          Mongo.userOnline(req.query.userId);
      }
  });
});


router.get("/login", function(req, res, next){

});




module.exports = router;
