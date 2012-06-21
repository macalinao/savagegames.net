mongoose = require 'mongoose'
Schema = mongoose.Schema

Player = require './player'

Game = new Schema
  type: String
  date: Date
  rankings: [{
    time: Number # If none then we have a winner
    player: { type: Schema.ObjectId, get: (id) -> Player.findById(id) } # Player
    kills: [Player.schema]
    class: String # Class used
  }]

module.exports = mongoose.model 'Game', Game
