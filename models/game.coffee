mongoose = require 'mongoose'
Schema = mongoose.Schema

Player = require './player'

Game = new Schema
  type: { type: String, required: yes }
  date: { type: Date, required: yes } # Date the game started
  rankings: [{
    time: Number # If none then we have a winner
    player: Schema.ObjectId # Player
    kills: [Player.schema]
    class: String # Class used
  }]

module.exports = mongoose.model 'Game', Game
