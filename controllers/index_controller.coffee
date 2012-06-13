request = require 'superagent'

loadNewsFeed = (cb) ->
  ###
  Loads the news feed of the website.
  ###
  request
    .get('https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://savage-games.enjin.com/home/m/5878790/rss/true')
    .end (data) ->
      cb JSON.parse(data.text).responseData.feed.entries

getNewsFeed = (cb) ->
  ###
  Gets the News feed of the website.

  TODO: cache
  ###
  loadNewsFeed cb

module.exports = (req, res) ->
  getNewsFeed (news) ->
    vars =
      news: news

    res.render 'index.jade', vars
