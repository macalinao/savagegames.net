mongoose = require 'mongoose'
Schema = mongoose.Schema

Game = new Schema
  type: { type: String, required: yes }
  date: { type: Date, required: yes } # Date the game started
  rankings: [new Schema {
    time: Number # Time of death (or win)
    player: { type: Schema.ObjectId, ref: 'Player' } # Player
    kills: [{ type: Schema.ObjectId, ref: 'Player' }]
    class: String # Class used
    rank: Number

    # Calculated
    score: Number
    killer: { type: Schema.ObjectId, ref: 'Player' }
  }]

Game.methods.scoreOfPlayer = (player) ->
  ranking = @getRankingOfPlayer player
  return ranking.score

Game.methods.getRankingOfPlayer = (player) ->
  pid = if player._id? then player._id else player # Check for one of those populated guys

  for ranking in @rankings
    rpid = if ranking.player._id? then ranking.player._id else ranking.player
    if rpid.toString() is pid.toString()
      return ranking

  return null

Game.methods.getWinner = ->
  return null if @rankings.length <= 0
  return @rankings[0].player

Game.methods.getLink = ->
  return '/games/' + @_id

Game.pre 'save', (next) ->
  # Calculate the scores
  @rankings.sort (a, b) ->
    return -1 if a.time < 0
    return 1 if b.time < 0
    if a.time isnt b.time
      return b.time - a.time
    return a.name.localeCompare b.name

  for ranking, i in @rankings
    ranking.score = i

  tkillers = {}
  for ranking in @rankings
    for kill in ranking.kills
      tkillers[kill] = ranking.player

  for ranking in @rankings
    ranking.killer = tkillers[ranking.player]

  next()

module.exports = mongoose.model 'Game', Game
