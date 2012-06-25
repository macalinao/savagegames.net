###
Contains all routes.
###
controllers = require '../lib/controllers'
Resource = require 'express-resource'

module.exports = (app) ->
  app.get '/', controllers.index
  app.get '/classes', controllers.classes.index
  app.get '/stats', controllers.stats.index
  app.get '/profiles/:name', controllers.profiles.index

  # Our API
  app.resource 'games', controllers.games
