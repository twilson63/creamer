# # Creamer
#
# A flatiron http plugin that adds `coffeecup` templates to your flatiron application
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
#     app.router.get '/', ->
#       @res.html app.bind -> h1 'Hello World'
#
#     app.start 3000
#
# ---
# require coffeecup
# [http://github.com/gradus/coffeecup](http://github.com/gradus/coffeecup)
cc = require 'coffeecup'
hardcode = require 'coffeecup-helpers'
# broadway plug attach method
#
# Plugin Options
#
#     Options      |    Description
#     -------------|----------------------------------------
#     layout       | CoffeeCup Template with content method
#     views        | Pre Register your views
#
exports.attach = (options={}) ->
  self = this
  merge = (x, y) ->
    x[k] = v for own k, v of y
    return x
  views = options.views || {}

  # ## app.bind(page, data)
  #
  #     Parameter    |   Type    |  Required?  |  Description
  #     -------------|-----------|-------------|-------------------------
  #     page         | function  | yes         | coffeecup template
  #     data         | object    | no          | any data you want to pass to your template
  @bind = (page, data) ->
    if options.layout?
      hardcode.content = page
      cc.render(options.layout, data, { hardcode, locals: true })
    else
      cc.render(page, data, { hardcode, locals: true})

  # ## app.regisgerHelper(name, fn)
  #
  @registerHelper = (name, fn) ->
    valid = cc.compile(fn, {hardcode, locals: true})
    hardcode[name] = fn if typeof fn is 'function'

  # ## app.registerView(name, fn)
  #
  @registerView = (name, fn) ->
    valid = cc.compile(fn, {hardcode, locals: true})
    views[name] = fn

  # if flatiron router exists, then attach creamers bind function
  @router.attach ( -> @bind = self.bind ) if @router?.attach?

  # init plugin method
exports.init = (done) -> done()
