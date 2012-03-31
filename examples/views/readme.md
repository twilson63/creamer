# flatiron with views example

Single file apps are great to experiment and scratch an itch, but over time it may get a little crowed to have some code that you are not using in your file.  No, need to have to continue to work around this code.  With Creamer you can easily start to move some of your views to separate files with out having to switch frameworks, libraries, etc.

The Creamer Plugin allows you to add a views directory option to the use method, when attaching the plugin to your application.  

``` coffeescript
app.use creamer, views: __dirname + '/views'
```

When you add this option to the creamer plugin, the plugin will recursively read all the files in that directory and register them with the application.  This gives a simple way to bind data to your coffeecup templates.  Because each view is already compiled and loaded as coffeescript, it will not block io on every request, the views are still cached and loaded into the application.

Check out the example.

## usage

```
cd examples/views
npm install
node server.js
```

## app.coffee

``` coffeescript

flatiron = require 'flatiron'
creamer = require 'creamer'
ecstatic = require 'ecstatic'

app = flatiron.app

app.use flatiron.plugins.http
app.use creamer, 
  views: __dirname + '/views'
  layout: require __dirname + '/views/layout'

app.http.before = [
  ecstatic __dirname + '/../public', autoIndex: off, cache: on
]

app.router.get '/', -> 
  @res.html @bind('index', { home: '.active' })

app.router.get '/:page', (page) ->
  options ?= {}
  options[page] = '.active'
  @res.html @bind(page, options)

app.start 3000, -> console.log 'running...'
`
