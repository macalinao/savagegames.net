###
Contains all routes.
###
controllers = require '../lib/controllers'

module.exports = (app) ->

  # Index
  app.get '/', controllers.index

  # Classes
  app.get '/classes', controllers.classes.show

