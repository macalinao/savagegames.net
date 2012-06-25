async = require 'async'
Player = require '../models/player'

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
        pDay: scores[0]
        pWeek: scores[1]
        pMonth: scores[2]
        pAlltime: scores[3]
