###
Contains all of our controllers.
###
fs = require 'fs'
path = require 'path'

controllers = {}

files = fs.readdirSync 'controllers/'
for file in files
  controllerPath = './controllers/' + file 
  unless fs.statSync(controllerPath).isDirectory()
    controllers[path.basename(file, '_controller.coffee')] = require controllerPath

module.exports = controllers
