###
Contains all routes.
###
controllers = require '../lib/controllers'
Resource = require 'express-resource'

module.exports = (app) ->
  app.get '/', controllers.index
  app.get '/classes', controllers.classes.index
  app.get '/stats', controllers.stats.index

  app.get '/games/:game', controllers.games.view

  app.get '/profiles/:name', controllers.profiles.view

  app.get '*', (req, res) -> res.render '404.jade'
