mongoose = require 'mongoose'
config = require '../config/config'
mongoose.connect config.development.database

Player = require '../models/player'

albireox = new Player name: 'AlbireoX'
albireox.save()

mongong = new Player name: 'Mongong'
mongong.save()

bluejayway = new Player name: 'BlueJayWay'
bluejayway.save()

photon75 = new Player name: 'Photon75'
photon75.save()

svinnik = new Player name: 'Svinnik'
svinnik.save()

##########
# GAMES
##########
Game = require '../models/game'
game1 = new Game
  type: 'Normal'
  date: Date.now() - (8 * 60 * 60 * 1000) # 8 hours ago
  rankings: [
    {
      time: -1 # Winner
      player: albireox
      kills: [mongong, bluejayway]
      class: 'Lumberjack'
    },
    {
      time: 400 # Last kill; game lasted 400 seconds
      player: mongong
      kills: []
      class: 'Firefighter'
    },
    {
      time: 200 # BJW died 200 seconds after start of game
      player: bluejayway
      kills: []
      class: 'Firefighter'
    }
  ]
game1.save()

game2 = new Game
  type: 'Desert'
  date: Date.now() - 1000
  rankings: [
    {
      time: -1 # Winner
      player: albireox
      kills: [photon75]
      class: 'Warrior'
    },
    {
      time: 200 # Game lasted 200 seconds
      player: photon75
      kills: [svinnik]
      class: 'Archer'
    },
    {
      time: 50
      player: svinnik
      kills: []
      class: 'Hacker' # :p
    }
  ]
game2.save()

mongoose.disconnect()
