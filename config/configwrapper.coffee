config = null
try
  config = require './config'
catch e
  config = {}
  config.development =
    database: 'mongodb://127.0.0.1/test'

module.exports = config
