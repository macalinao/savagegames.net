Game = require '../models/game'
Player = require '../models/player'

module.exports = 
  index: (req, res) ->
    name = req.params.name
    Player.findOne name_lower: name.toLowerCase(), (err, player) ->
      if err or not player?
        return res.render 'player404.jade'
          name: req.params.name

      player.prettyStatReport (err, stats) ->
        res.render 'profile.jade',
          player: player
          stats: stats
