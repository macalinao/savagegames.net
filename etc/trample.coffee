mongoose = require 'mongoose'
config = require '../config/configwrapper'
mongoose.connect config.development.database

require('../db/trample') ->
  mongoose.disconnect ->
    console.log 'Done trampling!'
    process.exit 0
