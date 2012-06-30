###
Contains all routes.
###
controllers = require '../lib/controllers'

module.exports = (app) ->
  app.get '/', controllers.index
  app.get '/classes', controllers.classes.index
  app.get '/servers', controllers.servers.index
  app.get '/stats', controllers.stats.index

  app.get '/games/:game', controllers.games.view

  app.get '/players/:name', controllers.players.view

  app.post '/reports', controllers.reports.index

  # API
  app.get '/api/ping_servers.json', controllers.api.pingServers

  app.get '*', (req, res) -> res.render '404.jade', status: 404
