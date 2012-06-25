mongoose = require 'mongoose'
Schema = mongoose.Schema

Game = new Schema
  type: { type: String, required: yes }
  date: { type: Date, required: yes } # Date the game started
  rankings: [new Schema {
    time: Number # If none then we have a winner; relative
    player: { type: Schema.ObjectId, ref: 'Player' } # Player
    kills: [{ type: Schema.ObjectId, ref: 'Player' }]
    class: String # Class used
    score: Number # Calculated on insert
  }]

Game.methods.scoreOfPlayer = (player) ->
  ranking = @getRankingOfPlayer player
  return ranking.score

Game.methods.getRankingOfPlayer = (player) ->
  pid = if player._id? then player._id else player # Check for one of those populated guys

  for ranking in @rankings
    rpid = if ranking.player._id? then ranking.player._id else ranking.player
    if rpid is pid
      return ranking

  return null

Game.pre 'save', (next) ->
  # Calculate the scores
  @rankings.sort (a, b) ->
    return -1 if a.time < 0
    return 1 if b.time < 0
    return b.time - a.time

  for i, ranking of @rankings
    ranking.score = i

  # Sort the ranks
  @rankings.sort (a, b) ->
    unless a.score is b.score
      return b.score - a.score
    return a.name.localeCompare b.name

  next()

module.exports = mongoose.model 'Game', Game
