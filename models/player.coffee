mongoose = require 'mongoose'
async = require 'async'
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

    for game in games
      ranking = game.getRankingOfPlayer @_id.toString()
      timePlayed += ranking.time
      wins += 1 if ranking.rank is 1
      top10Finishes += 1 if ranking.rank >= 10
      if bestFinish > ranking.rank
        bestFinish = ranking.rank
        bestFinishGame = game

    # Avg time
    averageTimeSurvived = timePlayed / gamesPlayed

    cb null,
      player: @this
      gameplay:
        gamesPlayed: gamesPlayed
        timePlayed: timePlayed
        averageTimeSurvived: averageTimeSurvived
        numberOfWins: wins
        top10Finishes: top10Finishes
        bestFinish: bestFinish
        bestFinishGame: bestFinishGame

Player.methods.games = (cb) ->
  @gamesSince new Date(0), cb

Player.methods.gamesSince = (date, cb) ->
  ###
  Gets the games the player has participated in since the given date.
  ###
  Game.where('rankings.player', @_id)
    .where('date').gte(date)
    .exec(cb)

Player.methods.scoreSince = (date, cb) ->
  ###
  Gets the score of the player since the given date.
  ###
  @gamesSince date, (err, games) ->
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
