# # Creamer
#
# A flatiron http plugin that adds coffeecup templates to your flatiron application
#
# install
#
#     npm install creamer
#
# usage
#
#     flatiron = require 'flatiron'
#     creamer = require 'creamer'
#     app = flatiron.app
#     layout = require __dirname + '/views/layout'
#     app.use creamer, layout: layout
#     
#     app.get '/', ->
#       app.render @res, -> h1 'Hello World'
#     
#     app.start 3000
#
# ---
# require coffeecup
# [http://github.com/gradus/coffeecup](http://github.com/gradus/coffeecup)
cc = require 'coffeecup'
# broadway plug attach method
# 
# Plugin Options
#
#     Options      |    Description
#     -------------|----------------------------------------
#     layout       | CoffeeCup Template with content method
# 
exports.attach = (options={}) ->
    # ## app.render(res, page, data)
    #
    #     Parameter    |   Type    |  Required?  |  Description
    #     -------------|-----------|-------------|-------------------------
    #     res          | object    | yes         | Http Response Object
    #     page         | function  | yes         | coffeecup template
    @render = (res, page, data={}) ->
      html = ''
      if options.layout?
        options.content = page
        html = cc.render(options.layout, data, locals: true, hardcode: options)
      else
        html = cc.render(page, data, locals: true, hardcode: options)
      res.writeHead 200, 'content-type': 'text/html'
      res.end html
  # init plugin method
  init: (done) -> done()
