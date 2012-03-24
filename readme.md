# Creamer

[![build status](https://secure.travis-ci.org/twilson63/creamer.png)](http://travis-ci.org/twilson63/creamer)


Creamer is a flatiron/broadway plugin that provides layout functionality for
coffeecup when using with flatiron.

## install

`npm install creamer`

## usage

``` coffeescript
flatiron = require 'flatiron'
creamer = require 'creamer'
app = flatiron.app
layout = require __dirname + '/views/layout'
app.use creamer, layout: layout

app.get '/', ->
  app.render @res, -> h1 'Hello World'

app.start 3000
```

## api

## app.render(res, template, data)

Parameter  |  Type    | Required    |  Description
-----------|----------|-------------|-------------
res        | object   | yes         | http response object
template   | function | yes         | coffeecup template

example

``` coffeescript
app.router.get '/', -> app.render @res, -> h1 'foo'
```

# roadmap

check [issues][1]

# contribute

everyone is welcome to contribute. patches, bugfixes, new features

1. create an [issue][1] on github so the community can comment on your idea
2. fork `creamer` in github
3. create a new branch `git checkout -b my_branch`
4. create tests for the changes you made
5. make sure you pass both existing and newly inserted tests
6. commit your changes
7. push to your branch `git push origin my_branch`
8. create an pull request

# tests

``` sh
npm install mocha -g
npm install
npm test

```

# license

see LICENSE

[1]: http://github.com/twilson63/creamer/issues