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
  }]

Game.methods.scoreOfPlayer = (player) ->
  return 1 # TODO

module.exports = mongoose.model 'Game', Game
