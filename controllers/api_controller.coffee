MCQuery = require 'mcquery'
query = new MCQuery()

module.exports =
  pingServers: (req, res) ->
    query.startSession 'test.voxton.net', 25565, (err, session) ->
      if err
        res.send '{"error":"pinging"}', 500
        return console.error err

      query.basic_stat session, (err, stat) ->
        res.send stat
