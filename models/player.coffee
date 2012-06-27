mongoose = require 'mongoose'
async = require 'async'
misc = require '../lib/misc'
Schema = mongoose.Schema

Game = require './game'

Player = new Schema
  name: { type: String, required: true }
  name_lower: String

Player.methods.statReport = (cb) ->
  @games (err, games) =>
    # Games played
    gamesPlayed = games.length

    # Time played
    timePlayed = 0

    # Wins
    wins = 0

    # Top 10 finishes
    top10Finishes = 0

    # Best finish
    bestFinish = 1000000
    bestFinishGame = null

    # Kills
    mostKills = -1
    mostKillsGame = null
    totalKills = 0

    # Temp vars
    playerKills = {}
    playerKilled = {}

    for game in games
      ranking = game.getRankingOfPlayer @_id.toString()
      timePlayed += ranking.time
      wins += 1 if ranking.rank is 1
      top10Finishes += 1 if ranking.rank >= 10
      if bestFinish > ranking.rank
        bestFinish = ranking.rank
        bestFinishGame = game

      # Pvp
      gk = ranking.kills.length
      if gk > mostKills
        mostKills = gk
        mostKillsGame = game
      totalKills += gk

      # Killed/kills stuff
      for kill in ranking.kills
        if playerKills[kill]?
          playerKills[kill] += 1
        else
          playerKills[kill] = 1

      if playerKilled[ranking.killer]?
        playerKilled[ranking.killer] += 1
      else
        playerKilled[ranking.killer] = 1

    # Avg time
    averageTimeSurvived = timePlayed / gamesPlayed

    # Avg kills
    averageKills = totalKills / gamesPlayed

    # Get killer/killed
    killersArr = []
    for id, kills of playerKilled
      killersArr.push
        id: id
        kills: kills
    killersArr.sort (a, b) ->
      return b.kills - a.kills

    killsArr = []
    for id, kills of playerKills
      killsArr.push
        id: id
        kills: kills
    killsArr.sort (a, b) ->
      return b.kills - a.kills

    mostKilledById = null
    mostKilledByKills = 0
    if killersArr.length > 0
      mostKilledById = killersArr[0].id
      mostKilledByKills = killersArr[0].kills

    mostKilledId = null
    mostKilledKills = 0
    if killsArr.length > 0
      mostKilledId = killsArr[0].id 
      mostKilledKills = killsArr[0].kills

    getKillPlayers = (cb) ->
      getMostKilledBy = (cbx) ->
        if mostKilledById is null
          return cbx null, null
        mongoose.model('Player').findById mostKilledById, cbx

      getMostKilledBy (err, mostKilledBy) ->
        if mostKilledId is null
          return cb err, mostKilledBy, null
        mongoose.model('Player').findById mostKilledId, (err, mostKilled) ->
          cb err, mostKilledBy, mostKilled

    @score (err, score) =>
      getKillPlayers (err, mostKilledBy, mostKilled) =>
        cb null,
          player: this
          score: score
          gameplay:
            gamesPlayed: gamesPlayed
            timePlayed: timePlayed
            averageTimeSurvived: averageTimeSurvived
            numberOfWins: wins
            top10Finishes: top10Finishes
            bestFinish: bestFinish
            bestFinishGame: bestFinishGame
          pvp:
            mostKills: mostKills
            mostKillsGame: mostKillsGame
            totalKills: totalKills
            averageKills: averageKills
            mostKilledBy: mostKilledBy
            mostKilledByKills: mostKilledByKills
            mostKilled: mostKilled
            mostKilledKills: mostKilledKills

Player.methods.prettyStatReport = (cb) ->
  @statReport (err, stats) ->
    cb err,
      player: stats.player
      score: stats.score
      gameplay:
        gamesPlayed: stats.gameplay.gamesPlayed + ' games'
        timePlayed: stats.gameplay.timePlayed + ' seconds'
        averageTimeSurvived: stats.gameplay.averageTimeSurvived + ' seconds'
        numberOfWins: stats.gameplay.numberOfWins + ' wins'
        top10Finishes: stats.gameplay.top10Finishes + ' games'
        bestFinish: misc.getOrdinal(stats.gameplay.bestFinish) + ' place'
        bestFinishGame: stats.gameplay.bestFinishGame
      pvp:
        mostKills: stats.pvp.mostKills + ' kills'
        mostKillsGame: stats.pvp.mostKillsGame
        totalKills: stats.pvp.totalKills + ' kills'
        averageKills: stats.pvp.averageKills.toFixed(2) + ' kills/game'
        mostKilledBy: (->
          if stats.pvp.mostKilledBy
            return 'Killed by ' + stats.pvp.mostKilledBy.name \
              + ' (' + stats.pvp.mostKilledByKills + ' times)'
          else
            return 'Immortal!'
        )()
        mostKilled: (->
          if stats.pvp.mostKilled
            return 'Killed ' + stats.pvp.mostKilled.name \
              + ' (' + stats.pvp.mostKilledKills + ' times)'
          else
            return 'PvP Noob'
        )()

Player.methods.getLink = ->
  return '/players/' + @name

Player.methods.games = (cb) ->
  @gamesSince new Date(0), cb

Player.methods.gamesSince = (date, cb) ->
  ###
  Gets the games the player has participated in since the given date.
  ###
  Game.where('rankings.player', @_id)
    .where('date').gte(date)
    .exec(cb)

Player.methods.score = (cb) ->
  @scoreSince new Date(0), cb

Player.methods.scoreSince = (date, cb) ->
  ###
  Gets the score of the player since the given date.
  ###
  @gamesSince date, (err, games) =>
    cb err, 0 if err
    
    total = 0
    for game in games
      total += game.scoreOfPlayer this

    cb err, total

Player.statics.recent = (date, cb) ->
  ###
  Gets all players who have played since the given date.
  ###
  Game
    .where('date').gte(date)
    .exec((err, games) ->
      players = []

      for game in games
        for ranking in game.rankings
          p = ranking.player
          players.push p unless players.indexOf(p) > -1

      cb err, players
    )

Player.statics.scoresSince = (date, cb) ->
  ###
  Gets the scores of all players since the given date and sorts them by score.
  ###
  Game
    .where('date').gte(date)
    .populate('rankings.player')
    .exec((err, games) ->
      players = {}

      for game in games
        for ranking in game.rankings
          p = ranking.player
          players[p.name] = 0 unless players[p.name]?
          players[p.name] += game.scoreOfPlayer p._id

      parr = []

      for name, score of players
        parr.push
          name: name
          score: score

      parr.sort (a, b) ->
        unless a.score is b.score
          return b.score - a.score

        return a.name.localeCompare b.name

      cb err, parr
    )

Player.pre 'save', (next) ->
  @name_lower = @name.toLowerCase()
  next()

module.exports = mongoose.model 'Player', Player
