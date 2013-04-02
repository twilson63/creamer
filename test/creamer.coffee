creamer = require '..'
broadway = require 'broadway'
expect = require 'expect.js'

render = (t, layout) ->
  app = new broadway.App()
  app.use creamer, layout: if layout? then layout else null
  app.init()
  app.bind(t)

describe 'creamer', ->
  htmlf = (html) -> html.replace /(\n\s+|\n+)/g, ''
  describe '#attach()', ->
    it 'should allow for content_for style yields', ->
      layout = ->
        html ->
          body ->
            content()
            @header() if @header?
            div ->
              @body()
            @footer() if @footer?
      t = ->
        @header = -> h1 'Header'
        @body = -> p 'Hello World'
        @footer = -> footer 'Footer'
      output = htmlf """
<html>
  <body>
    <h1>Header</h1>
    <div>
      <p>Hello World</p>
    </div>
    <footer>Footer</footer>
  </body>
</html>
      """
      app = new broadway.App()
      app.use creamer, layout: if layout? then layout else null
      app.init()
      expect(app.bind(t)).to.be output    
    it 'should load views', ->
      output = htmlf """
<h1>view2</h1>
      """
      app = new broadway.App()
      app.use creamer, views: __dirname + '/views'
      app.init()
      expect(app.bind('folder/view2')).to.be output

  describe '#registerViews', ->
    it 'should register view and render view by name', ->
      output = htmlf """
<h1>view1</h1>
      """
      app = new broadway.App()
      app.use creamer #, layout: layout
      app.init()
      app.registerView 'view1', require('./views/view1')
      expect(app.bind('view1')).to.be output

  describe '#bind(page, data)', ->
    it 'should attach to broadway app', ->
      t = ->
        h1 'Hello World'
      output = htmlf """
<h1>Hello World</h1>
      """
      expect(render(t)).to.be output
    it 'should handle layout template', ->
      layout = ->
        html ->
          content()
      t = ->
        h1 'Hello World'
      output = htmlf """
<html>
  <h1>Hello World</h1>
</html>
      """
      expect(render(t, layout)).to.eql output
  describe '#registerHelper(name, fn)', ->
    it 'should register my custom helper', ->
      layout = -> html -> body -> content()
      helper = (foo) -> h1 foo
      t = -> div '.index', -> bigfoo('foo')
      output = htmlf """
<html>
  <body>
    <div class="index">
      <h1>foo</h1>
    </div>
  </body>
</html>
      """
      app = new broadway.App()
      app.use creamer, layout: layout
      app.init()
      app.registerHelper 'bigfoo', helper
      expect(app.bind(t)).to.be output