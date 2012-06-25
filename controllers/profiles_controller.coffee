Game = require '../models/game'
Player = require '../models/player'

module.exports = 
  index: (req, res) ->
    name = req.params.name
    Player.findOne name_lower: name.toLowerCase(), (err, player) ->
      player.statReport (err, stats) ->
        if err or not player?
          res.send '404', 404

        res.render 'profile.jade',
          player: player
          stats: stats
