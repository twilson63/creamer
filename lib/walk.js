var fs, walk;

fs = require('fs');

module.exports = walk = function(dir, done) {
  var results;
  results = [];
  return fs.readdir(dir, function(err, list) {
    var file, name, pending, stat, _i, _len, _results;
    if (err) return done(err, []);
    pending = list.length;
    if (!pending) return done(null, results);
    _results = [];
    for (_i = 0, _len = list.length; _i < _len; _i++) {
      name = list[_i];
      file = "" + dir + "/" + name;
      try {
        stat = fs.statSync(file);
      } catch (err) {
        stat = null;
      }
      if (stat != null ? stat.isDirectory() : void 0) {
        _results.push(walk(file, function(err, res) {
          var name, _j, _len2;
          for (_j = 0, _len2 = res.length; _j < _len2; _j++) {
            name = res[_j];
            results.push(name);
          }
          if (!--pending) return done(null, results);
        }));
      } else {
        results.push(file);
        if (!--pending) {
          _results.push(done(null, results));
        } else {
          _results.push(void 0);
        }
      }
    }
    return _results;
  });
};
