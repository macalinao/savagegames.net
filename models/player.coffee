mongoose = require 'mongoose'
Schema = mongoose.Schema

Player = new Schema
  name: { type: String, required: true }

module.exports = mongoose.model 'Player', Player
