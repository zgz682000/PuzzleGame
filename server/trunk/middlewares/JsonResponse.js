/**
 * Created by zhangguozhi on 16/5/19.
 */

module.exports.successHandler = function(req, res, next){
    var responseObj = {
        code : 0,
        msg : "success",
        data : res.data
    }
    res.json(responseObj);
}

module.exports.errerHandler = function(err, req, res, next){
    var responseObj = {
        code : err.code,
        msg : err.message
    }
    res.json(responseObj);
}

