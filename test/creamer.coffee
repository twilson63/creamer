creamer = require '..'
broadway = require 'broadway'

describe 'creamer', ->
  it 'should attach to broadway app', ->
    res = 
      writeHead: (status, headers) ->
        @headers = headers
        @headers.status = status
      end: (html) -> @body = html

    template = ->
      h1 'Hello World'
    app = new broadway.App()
    app.use creamer
    app.init()
    app.render(res, template)
    res.body.should.equal('<h1>Hello World</h1>')
  it 'should handle layout template', ->
    res = 
      writeHead: (status, headers) ->
        @headers = headers
        @headers.status = status
      end: (html) -> @body = html

    layout = ->
      html ->
        content()
    template = ->
      h1 'Hello World'
    app = new broadway.App()
    app.use creamer, { layout }
    app.init()
    app.render(res, template)
    res.body.should.equal('<html><h1>Hello World</h1></html>')
