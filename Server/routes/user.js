
/*
 * GET users listing.
 */
var passport = require('passport'),
    users = require('../models/users');

exports.login = function(req, res, next) {
  passport.authenticate('local', function(err, user, info) {
    if (err) { return next(err); }
    if (!user) {
      return res.send(401);
    }
    req.logIn(user, function(err) {
      if (err) { return next(err); }
      return res.json({ "user": user });
    });
  })(req, res, next);
};

exports.logout = function(req, res) {
  req.logout();
  res.json({ "message": { "description": "User is logged out." }});
};
