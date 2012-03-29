var cc, fs, hardcode, wrench;

cc = require('coffeecup');

hardcode = require('coffeecup-helpers');

fs = require('fs');

wrench = require('wrench');

exports.attach = function(options) {
  var fn, name, registeredViews, self, view, views, _i, _len, _ref;
  if (options == null) options = {};
  self = this;
  registeredViews = {};
  if (options.viewDir != null) {
    views = wrench.readdirSyncRecursive(options.viewDir);
    for (_i = 0, _len = views.length; _i < _len; _i++) {
      view = views[_i];
      if (view.match(/(.js|.coffee)/)) {
        fn = require(options.viewDir + '/' + view);
        name = view.split('.').shift();
        registeredViews[name] = fn;
      }
    }
  }
  this.bind = function(page, data) {
    if (typeof page === 'string') page = registeredViews[page];
    if ((options.layout != null) && typeof page === 'function') {
      hardcode.content = page;
      return cc.render(options.layout, data, {
        hardcode: hardcode,
        locals: true
      });
    } else if (typeof page === 'function') {
      return cc.render(page, data, {
        hardcode: hardcode,
        locals: true
      });
    } else {
      return '<p>Not Found</p>';
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
    return registeredViews[name] = fn;
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
