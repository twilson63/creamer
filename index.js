var cc, hardcode,
  __hasProp = Object.prototype.hasOwnProperty;

cc = require('coffeecup');

hardcode = require('coffeecup-helpers');

exports.attach = function(options) {
  var merge, self, views, _ref;
  if (options == null) options = {};
  self = this;
  merge = function(x, y) {
    var k, v;
    for (k in y) {
      if (!__hasProp.call(y, k)) continue;
      v = y[k];
      x[k] = v;
    }
    return x;
  };
  views = options.views || {};
  this.bind = function(page, data) {
    if (options.layout != null) {
      hardcode.content = page;
      return cc.render(options.layout, data, {
        hardcode: hardcode,
        locals: true
      });
    } else {
      return cc.render(page, data, {
        hardcode: hardcode,
        locals: true
      });
    }
  };
  this.registerHelper = function(name, fn) {
    var valid;
    valid = cc.compile(fn, {
      hardcode: hardcode,
      locals: true
    });
    if (typeof fn === 'function') return hardcode[name] = fn;
  };
  this.registerView = function(name, fn) {
    var valid;
    valid = cc.compile(fn, {
      hardcode: hardcode,
      locals: true
    });
    return views[name] = fn;
  };
  if (((_ref = this.router) != null ? _ref.attach : void 0) != null) {
    return this.router.attach((function() {
      return this.bind = self.bind;
    }));
  }
};

exports.init = function(done) {
  return done();
};
