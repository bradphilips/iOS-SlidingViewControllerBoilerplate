var passport = require('passport'),
    crypto = require('crypto'),
    LocalStrategy = require('passport-local').Strategy;

var users = [
    { id: 1, username: 'brad', email: 'brad.t.philips@gmail.com' }, // user: brad, password: secure
    { id: 2, username: 'test', email: 'test@example.com' } // user: test, password: mctester
];

var passwords = [
  { id: 1, password: 'e4b2a5325a59f857fa7881970ccc878cb9b2af70', salt: '486583348139' },
  { id: 2, password: '1cc283d5f47b4738a9654eb98344a4b23e63c757', salt: '999010479633' },
]

function makeSalt() {
  return Math.round((new Date().valueOf() * Math.random())) + '';
}

function encryptPassword(password, salt) {
  var password = crypto.createHmac('sha1', salt).update(password).digest('hex');
  return password;
}

function findById(id, done) {
  var idx = id - 1;
  if (users[idx]) {
    done(null, users[idx]);
  } else {
    done(new Error('User ' + id + ' does not exist'));
  }
};

function findByUsername(username, done) {
  for (var i = 0, len = users.length; i < len; i++) {
    var user = users[i];
    if (user.username === username) {
      return done(null, user);
    }
  }
  return done(null, null);
};

function getPasswordForUserId(id, done) {
  for (var i = 0, len = users.length; i < len; i++) {
    var password = passwords[i];
    if (password.id === id) {
      return done(null, password);
    }
  }
  return done(null, null);
}

passport.serializeUser(function(user, done) {
  done(null, user.id);
});

passport.deserializeUser(function(id, done) {
  findById(id, function (err, user) {
    done(err, user);
  });
});

passport.use(new LocalStrategy(
  function(username, password, done) {
    // asynchronous verification, for effect...
    process.nextTick(function () {

      // Find the user by username.  If there is no user with the given
      // username, or the password is not correct, set the user to `false` to
      // indicate failure and set a flash message.  Otherwise, return the
      // authenticated `user`.
      findByUsername(username, function(err, user) {
        if (err) { return done(err); }
        if (!user) { return done(null, false, { message: 'Unknown user ' + username }); }
        getPasswordForUserId(user.id, function(err, pass) {
          encryptPassword(password, makeSalt());
          if (pass.password != encryptPassword(password, pass.salt)) { return done(null, false, { message: 'Invalid password' }); }
          return done(null, user);
        });
      });
    });
  }
));