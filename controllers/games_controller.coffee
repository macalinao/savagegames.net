Game = require '../models/game'
Player = require '../models/player'
async = require 'async'

module.exports =
  index: (req, res) ->
    res.render 'games/index.jade'

  view: (req, res, next) ->
    Game.findOne()
      .where('linkid', req.params.game)
      .populate('rankings.kills')

      .exec (err, game) ->
        if err or not game
          return next()

        async.map game.rankings, (ranking, cb) ->
          Player.findById ranking.player, (err, player) ->
            return cb err, null if err
            return cb null, player
        , (err, players) ->
          res.render 'games/game.jade'
            game: game
            players: players
