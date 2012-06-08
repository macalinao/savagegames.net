"""
Contains all routes.
"""

module.exports = (app) ->

  # Index
  app.get '/', (req, res) ->
    res.render 'index.jade'
