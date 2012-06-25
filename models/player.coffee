mongoose = require 'mongoose'
async = require 'async'
Schema = mongoose.Schema

Game = require './game'

Player = new Schema
  name: { type: String, required: true }

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

module.exports = mongoose.model 'Player', Player
