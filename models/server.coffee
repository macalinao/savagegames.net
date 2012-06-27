mongoose = require 'mongoose'
Schema = mongoose.Schema

Server = new Schema
  ip: { type: String, required: yes } # The nicely formatted ip of the server.
  port: { type: String, required: yes, default: 25565 } # The port of the server.
  location: { type: String, required: yes } # Geographical location, like US or something
  secret: { type: String, required: yes } # The secret key that the server will use to communicate with us, UNIQUE
  type: { type: String, required: yes, default: 'Survival' } # Obvious

Server.methods.formattedIp = ->
  ###
  Gets us a nicely formatted IP.
  ###
  if port isnt 25565
    return ip + ':' + port
  return ip

module.exports = mongoose.model 'Server', Server
