###
Get it? You're trampling the seeds. Minecraft reference.
###

mongoose = require 'mongoose'
config = require '../config/config'
mongoose.connect config.development.database

Player = require '../models/player'
Player.collection.drop()

Game = require '../models/game'
Game.collection.drop()

mongoose.disconnect()

console.log 'Done'
process.exit 0
