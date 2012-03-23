# Creamer

Creamer is a broadway plugin that provides layout functionality for
coffeecup when using with flatiron.

## install

`npm install creamer`

## usage

``` coffeescript
broadway = require 'broadway'
creamer = require 'creamer'

app = new broadway.App()
app.use creamer
app.init()

app.render ->
  h1 'FooBar'
```
