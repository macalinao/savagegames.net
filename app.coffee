express = require 'express'

module.exports = app = express.createServer()

require('./config/environment') app, express
require('./config/routes') app

# Setup the port
app.listen 80
