###
Contains all routes.
###
controllers = require '../lib/controllers'
Resource = require 'express-resource'

module.exports = (app) ->

  # Index
  app.get '/', controllers.index

  # Classes
  app.get '/classes', controllers.classes.show

  # Our API
  app.resource 'games', controllers.games
