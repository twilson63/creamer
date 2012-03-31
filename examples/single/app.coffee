flatiron = require 'flatiron'
creamer = require 'creamer'

app = flatiron.app
app.use flatiron.plugins.http
app.use creamer, layout: ->
  doctype 5
  html ->
    head ->
      title 'Single Page'
    body ->
      content()

app.router.get '/', ->
  @res.html @bind -> h1 'Hello Creamer'
app.start 3000, -> console.log 'Listening...'
