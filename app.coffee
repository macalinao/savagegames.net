express = require 'express'
stylus = require 'stylus'

module.exports = app = express.createServer()

# Configure app
app.configure ->

  app.use express.methodOverride()
  app.use express.bodyParser()

  app.use stylus.middleware
    src: __dirname + "/views"
    dest: __dirname + "/public"
    compile: (str, path, fn) ->
      stylus(str)
        .set('filename', path)
        .set('compress', true)
        .render(fn)

  app.set 'view engine', 'ejs'
  app.use express.static(__dirname + "/public")

# Development
app.configure 'development', ->
  app.use express.errorHandler
    dumpExceptions: yes
    showStack: yes

# Production
app.configure 'production', ->
  app.use express.errorHandler

# Routes
require('./lib/routes') app

# Setup the port
app.listen 3535
