var cc, helpers;

cc = require('coffeecup');

helpers = require('coffeecup-helpers');

exports.attach = function(options) {
  var hardcode;
  if (options == null) options = {};
  hardcode = helpers;
  this.bind = function(page, data) {
    if (options.layout != null) {
      helpers.content = page;
      return cc.render(options.layout, data, {
        locals: true,
        hardcode: helpers
      });
    } else {
      return cc.render(page, data, {
        locals: true,
        hardcode: helpers
      });
    }
  };
  return this.render = function(res, page, data) {
    var html;
    if (data == null) data = {};
    html = this.bind(page, data);
    res.writeHead(200, {
      'content-type': 'text/html'
    });
    return res.end(html);
  };
};

exports.init = function(done) {
  return done();
};
