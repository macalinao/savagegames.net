mongoose = require 'mongoose'
config = require '../config/config'
mongoose.connect config.development.database

Player = require '../models/player'

player1 = new Player name: 'AlbireoX'
player1.save()

player2 = new Player name: 'Mongong'
player2.save()

player3 = new Player name: 'BlueJayWay'
player3.save()

Game = require '../models/game'
game1 = new Game
  type: 'Normal'
  date: Date.now() - 1000 * 5
  rankings: [{
    time: -1
    player: player1._id
    kills: [player2, player3]
    class: 'Lumberjack'
  }]
game1.save()

mongoose.disconnect()
