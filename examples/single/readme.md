# Flatiron Single File App

This is an example of a flatiron coffeecup single file app.

Basically, the entire application is one file, this is a nice advantage of coffeecup and creamer.  Since CoffeeCup is CoffeeScript, you can put all of your markup in the same file as your application logic.

``` coffeescript
flatiron = require 'flatiron'
creamer = require 'creamer'

app = flatiron.app
app.use flatiron.plugins.http
app.use creamer, layout: ->
  doctype 5
  html ->
    head ->
      title 'Single File Application'
    body ->
      content()

app.router.get '/', -> @res.html @bind -> h1 'Hello World'

app.start 3000, -> console.log 'Listening...'
```