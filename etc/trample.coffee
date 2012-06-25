###
Get it? You're trampling the seeds. Minecraft reference because we're a Minecraft server.
###
async = require 'async'
mongoose = require 'mongoose'
config = require '../config/config'
mongoose.connect config.development.database

models = [
  require '../models/player',
  require '../models/game'
]

async.forEach models, (item, callback) ->
  item.collection.drop()
  callback()
, (err) ->
  mongoose.disconnect()

  console.log 'Done'
  process.exit 0
