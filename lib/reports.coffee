Server = require '../models/server'
Game = require '../models/game'

exports.parse = (report, cb) ->
  ###
  Parses a received report into a game.
  
  @param report The report to parse.
  @param cb(err, game) Callback
  ###
  try
    Server.findOne().where('secret', report.secret).exec (err, server) ->
      if err or not server
        return cb new Error('Unknown server'), null

      game = new Game
        server: server

        type: report.type
        date: new Date(report.date)
        rankings: (->
          rankings = []
          for rk in report.rankings
            rankings.push
              time: rk.time
              player: rk.player
              kills: rk.kills
              class: rk.class
              rank: rk.rank
          return rankings
        )()

      cb null, game

  catch e
    cb e, null
