# MVC Example

Ok, flatiron is great a doing api's and very simple apps, but what about complex applications that need a consistent organization style and workflow, that teams may iterate on.  Time to re-write your app in Rails or something right?

I don't think so, I think you can achieve large scale applications with flatiron with ease.  With modules like creamer and resourceful, it is extremely easy to update your single file or views oriented app and upgrade the backend to support controllers and models.  

## Controllers

Creamer allows you to set a controllers directory and creamer will register and mount each controller specified in the controllers folder.

app.coffee

``` coffeescript
app.use creamer, controllers: __dirname + '/controllers'
```

controllers/widgets.coffee

``` coffeescript
module.exports =
  '/widgets':
    get: ->
      Widget.all (err, widgets) =>
        @res.html @bind('widgets/index', { widgets: '.active', widgets: widgets } )
```

The director module for flatiron allows us to mount routes by passing it an object, which keys are the paths and then each key underneath the path matches the method.  This gives us a very simple way of abstracting out controllers.  These objects also contain the ability to add before and after filters in the objects.  For more info see: [https://github.com/flatiron/director#routing-table](https://github.com/flatiron/director#routing-table)

## Models

With flatiron, there is a module called resourceful, that has a fantastic api for implementing models.  This api is built to be datastore agnostic, there are several datastore engines available.  Ones for memory and couchdb are included.

Creamer does not do anything special with models, it is assumed that you will want to require the models at the controller level, which is very easy to do.

Check it out.

## usage

```
npm install
cake build
node server.js
```
