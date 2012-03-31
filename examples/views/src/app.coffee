flatiron = require 'flatiron'
creamer = require '../../../'
ecstatic = require 'ecstatic'

app = flatiron.app

app.use flatiron.plugins.http
app.use creamer, 
  views: __dirname + '/views'
  layout: require __dirname + '/views/layout'

app.http.before = [
  ecstatic __dirname + '/../public', autoIndex: off, cache: on
]

app.router.get '/', -> @bind('index', { home: '.active' })

app.router.get '/:page', (page) ->
  options ?= {}
  options[page] = '.active'
  @bind(page, options)

app.start 3000, -> console.log 'running...'
