pStats = require '../lib/player_stats'

module.exports =
  index: (req, res) ->
    res.render 'stats.jade',
      pDay: pStats.dayScores()
      pWeek: pStats.weekScores()
      pMonth: pStats.monthScores()
      pAlltime: pStats.alltimeScores()
