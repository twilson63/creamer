creamer = require '../lib'
broadway = require 'broadway'


describe 'creamer', ->
  it 'should attach to broadway app', ->
    template = ->
      h1 'Hello World'
    app = new broadway.App()
    app.use creamer
    app.init()
    app.render(template).should.equal('<h1>Hello World</h1>')
  it 'should handle layout template', ->
    layout = ->
      html ->
        content()
    template = ->
      h1 'Hello World'
    app = new broadway.App()
    app.use creamer, { layout }
    app.init()
    app.render(template).should.equal('<html><h1>Hello World</h1></html>')
    
