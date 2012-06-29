mongoose = require 'mongoose'
net = require 'net'
Schema = mongoose.Schema

Server = new Schema
  ip: { type: String, required: yes } # The nicely formatted ip of the server.
  port: { type: String, required: yes, default: 25565 } # The port of the server.
  ping_port: { type: Number, required: yes } # Ping server port
  location: { type: String, required: yes, default: 'US' } # Geographical location, like US or something
  secret: { type: String, required: yes } # The secret key that the server will use to communicate with us, UNIQUE
  type: { type: String, required: yes, default: 'Survival' } # Obvious

Server.methods.createConnection = -> 
  ###
  Creates a connection to the server's info stuff.
  ###
  # return net.createConnection @port, @ip

Server.methods.formattedIp = ->
  ###
  Gets us a nicely formatted IP.
  ###
  if port isnt 25565
    return ip + ':' + port
  return ip

Server.statics.getPingInfo = (conn, cb) ->
  ###
  Gets information about a ping.
  
  @param conn The connection.
  @param cb(err, data) The ping data
  ###
  conn.on 'data', (data) ->
    try
      info = JSON.parse data
      cb null, info
    catch error
      return cb error, null

  conn.write 'GIMME_INFO\n', 'utf8'

module.exports = mongoose.model 'Server', Server
