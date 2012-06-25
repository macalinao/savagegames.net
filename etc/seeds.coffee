async = require 'async'
mongoose = require 'mongoose'
config = require '../config/config'
mongoose.connect config.development.database

Player = require '../models/player'

albireox = new Player name: 'AlbireoX'
mongong = new Player name: 'Mongong'
bluejayway = new Player name: 'BlueJayWay'
photon75 = new Player name: 'Photon75'
svinnik = new Player name: 'Svinnik'

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

# Save it all!
async.parallel [
  # Players
  (cb) -> albireox.save(-> cb null),
  (cb) -> mongong.save(-> cb null),
  (cb) -> bluejayway.save(-> cb null),
  (cb) -> photon75.save(-> cb null),
  (cb) -> svinnik.save(-> cb null),

  # Games
  (cb) -> game1.save(-> cb null),
  (cb) -> game2.save(-> cb null)
], (err, results) ->
  mongoose.disconnect()
  console.log 'Done'
  process.exit 0
