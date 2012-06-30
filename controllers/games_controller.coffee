Game = require '../models/game'
Player = require '../models/player'
async = require 'async'

module.exports =
  index: (req, res) ->
    res.render 'games/index.jade'

  view: (req, res, next) ->
    Game.findOne()
      .where('linkid', req.params.game)

      .exec (err, game) ->
        if err or not game
          return next()

        playerIds = {}
        async.map game.rankings, (ranking, cb) ->
          Player.findById ranking.player, (err, player) ->
            return cb err, null if err
            playerIds[ranking.player] = player
            return cb null, player
        , (err, players) ->
          res.render 'games/game.jade'
            game: game
            players: players
            ids: playerIds
