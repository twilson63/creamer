var cc;

cc = require('coffeecup');

exports.attach = function(options) {
  if (options == null) options = {};
  return this.render = function(res, page, data) {
    var html;
    if (data == null) data = {};
    html = '';
    if (options.layout != null) {
      options.content = page;
      html = cc.render(options.layout, data, {
        locals: true,
        hardcode: options
      });
    } else {
      html = cc.render(page, data, {
        locals: true,
        hardcode: options
      });
    }
    res.writeHead(200, {
      'content-type': 'text/html'
    });
    return res.end(html);
  };
};

({
  init: function(done) {
    return done();
  }
});
