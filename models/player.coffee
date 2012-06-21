mongoose = require 'mongoose'
Schema = mongoose.Schema

Player = new Schema
  name: String

module.exports = mongoose.model 'Player', Player
