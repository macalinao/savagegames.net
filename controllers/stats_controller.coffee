async = require 'async'
Player = require '../models/player'
Game = require '../models/game'

limit = (arr) ->
  return arr.splice(0, 9) if arr.length > 10
  return arr

module.exports =
  index: (req, res) ->
    month = new Date()
    month.setDate(0)
    month.setHours(0)
    month.setMinutes(0)
    month.setSeconds(0)
    month.setMilliseconds(0)

    async.map [
      new Date(Date.now() - 24 * 60 * 60 * 1000),
      new Date(Date.now() - 7 * 24 * 60 * 60 * 1000),
      month,
      new Date(0),
    ], Player.scoresSince, (err, scores) ->
      res.render 'stats.jade',
        pDay: limit scores[0]
        pWeek: limit scores[1]
        pMonth: limit scores[2]
        pAlltime: limit scores[3]
        games: Game.find().populate('rankings.player').limit(10).exec()
