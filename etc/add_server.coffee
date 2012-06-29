mongoose = require 'mongoose'
config = require '../config/configwrapper'
mongoose.connect config.production.database
Server = require '../models/server'
argv = require('optimist')
  .usage('Add a server to the database.')

  .demand('ip')
  .alias('ip', 'i')
  .describe('ip', 'The server ip')

  .demand('loc')
  .alias('loc', 'l')
  .describe('loc', 'The location of the server')

  .demand('secret')
  .alias('secret', 's')
  .describe('secret', 'The secret key of the server')

  .demand('pingp')
  .alias('pingp', 'n')
  .describe('pingp', 'The ping port of the server')

  .argv

server = new Server
  ip: argv.ip
  location: argv.loc
  secret: argv.secret
  ping_port: argv.pingp

server.save (err) ->
  return console.log err if err

  console.log 'Server added successfully.'
  process.exit 0
