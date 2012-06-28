config = require './configwrapper'
mongoose = require 'mongoose'

module.exports = (app, express) ->
  # Configure app
  app.configure ->
    app.use express.methodOverride()
    app.use express.bodyParser()

    app.use require('connect-assets')()
    require 'express-mongoose'

    app.set 'view engine', 'jade'
    app.set 'view options', pretty: false, layout: true
    app.use express.static(__dirname + "/public")
    app.use express.bodyParser()

  # Development
  app.configure 'development', ->
    app.use express.errorHandler
      dumpExceptions: yes
      showStack: yes
    mongoose.connect config.development.database

  # Production
  app.configure 'production', ->
    app.use express.errorHandler
    mongoose.connect config.production.database
