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
helpers = require 'coffeecup-helpers'
# broadway plug attach method
# 
# Plugin Options
#
#     Options      |    Description
#     -------------|----------------------------------------
#     layout       | CoffeeCup Template with content method
# 
exports.attach = (options={}) ->
  hardcode = helpers
  # ## app.bind(page, data)
  #
  #     Parameter    |   Type    |  Required?  |  Description
  #     -------------|-----------|-------------|-------------------------
  #     page         | function  | yes         | coffeecup template
  #     data         | object    | no          | any data you want to pass to your template
  @bind = (page, data) ->
    if options.layout?
      helpers.content = page
      cc.render(options.layout, data, locals: true, hardcode: helpers)
    else
      cc.render(page, data, locals: true, hardcode: helpers)
    
  # TODO
  # ## app.helpers(obj)
  #@helpers = (obj) ->
    
  # ## app.render(res, page, data)
  #
  #     Parameter    |   Type    |  Required?  |  Description
  #     -------------|-----------|-------------|-------------------------
  #     res          | object    | yes         | Http Response Object
  #     page         | function  | yes         | coffeecup template
  #     data         | object    | no          | any data you want to pass to your template
  @render = (res, page, data={}) ->
    html = @bind page, data
    res.writeHead 200, 'content-type': 'text/html'
    res.end html
  # init plugin method
exports.init = (done) -> done()
