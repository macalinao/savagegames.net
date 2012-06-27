Game = require '../models/game'

module.exports =
  index: (req, res) ->
    res.render 'games/index.jade'

  view: (req, res, next) ->
    Game.findOne().where('linkid', req.params.game)
      .populate('rankings.player')
      .populate('rankings.kills')

      .exec (err, game) ->
        if err or not game
          return next()

        res.render 'games/game.jade'
          game: game
