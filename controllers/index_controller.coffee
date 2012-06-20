request = require 'superagent'

# Poor man's cache
nextTime = 0
cachedNews = []

loadNewsFeed = (cb) ->
  ###
  Loads the news feed of the website.
  ###
  request
    .get('https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://savage-games.enjin.com/home/m/5878790/rss/true')
    .end (data) ->
      entries = null
      try
        entries = JSON.parse(data.text).responseData.feed.entries
      catch e
        entries = []
      cb entries

getNewsFeed = (cb) ->
  ###
  Gets the News feed of the website.

  TODO: cache
  ###
  if Date.now() > nextTime
    nextTime = Date.now() + (120 * 1000)
    loadNewsFeed (news) ->
      cachedNews = news
      cb cachedNews
  else
    cb cachedNews

module.exports = (req, res) ->
  getNewsFeed (news) ->
    vars =
      news: news

    res.render 'index.jade', vars
