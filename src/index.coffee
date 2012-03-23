cc = require 'coffeecup'
exports.attach = (options={}) ->
    @render = (page, data={}) ->
      if options.layout?
        options.content = page
        cc.render options.layout, data, locals: true, hardcode: options
      else
        cc.render page, data, locals: true, hardcode: options
  init: (done) -> done()
