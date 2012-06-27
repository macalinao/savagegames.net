module.exports = config = require './config'
unless config
  config.development =
    database: 'mongodb://127.0.0.1/test'
