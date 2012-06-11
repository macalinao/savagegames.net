"""
Contains all routes.
"""
controllers = require './controllers'

module.exports = (app) ->

  # Index
  app.get '/', controllers.index

  # Classes
  app.get '/classes', controllers.classes.show

