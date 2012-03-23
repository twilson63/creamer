var cc;

cc = require('coffeecup');

exports.attach = function(options) {
  if (options == null) options = {};
  return this.render = function(page, data) {
    if (data == null) data = {};
    if (options.layout != null) {
      options.content = page;
      return cc.render(options.layout, data, {
        locals: true,
        hardcode: options
      });
    } else {
      return cc.render(page, data, {
        locals: true,
        hardcode: options
      });
    }
  };
};

({
  init: function(done) {
    return done();
  }
});
