"""
Contains all routes.
"""
news = require './news'

module.exports = (app) ->

  # Index
  app.get '/', (req, res) ->
    news.getNewsFeed (news) ->
      vars = {
        news: news
      }
      res.render 'index.jade', vars
