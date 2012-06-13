module.exports = (app, express) ->
  # Configure app
  app.configure ->
    app.use express.methodOverride()
    app.use express.bodyParser()

    app.use require('connect-assets')()

    app.set 'view engine', 'jade'
    app.set 'view options', pretty: true
    app.use express.static(__dirname + "/public")

  # Development
  app.configure 'development', ->
    app.use express.errorHandler
      dumpExceptions: yes
      showStack: yes

  # Production
  app.configure 'production', ->
    app.use express.errorHandler
