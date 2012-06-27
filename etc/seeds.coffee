mongoose = require 'mongoose'
config = require '../config/configwrapper'
mongoose.connect config.development.database

require('../db/seeds') ->
  mongoose.disconnect ->
    console.log 'Done seeding!'
    process.exit 0
