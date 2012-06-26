Game = require '../models/game'

module.exports =
  view: (req, res) ->
    res.render 'game.jade'