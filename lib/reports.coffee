Server = require '../models/server'

exports.parse = (report, cb) ->
  ###
  Parses a received report into a game.
  
  @param report The report to parse.
  @param cb(err, game) Callback
  ###
  try
    Server.getServer reports.server, (err, server) ->
      if err or not server
        return cb err, null

      # Now we have the server

  catch e
    cb e, null
