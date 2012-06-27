###
Get it? You're trampling the seeds. Minecraft reference because we're a Minecraft server.
###
async = require 'async'
mongoose = require 'mongoose'

module.exports = (done) ->
  models = [
    require('../models/player'),
    require('../models/game'),
    require('../models/server')
  ]

  async.forEach models, (item, callback) ->
    item.collection.drop ->
      callback()
  , done
