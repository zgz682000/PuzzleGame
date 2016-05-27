/**
 * Created by apple on 16/5/26.
 */

var Mongo = require("./../service/Mongo");

module.exports = function(res, rep, next){
    var userId = req.query.userId;
    Mongo.userOnline(userId);
    next();
}