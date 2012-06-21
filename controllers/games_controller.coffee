Game = require '../models/game'

exports.index = (req, res) ->
  res.render 'games/index.jade'

exports.new = (req, res) ->
  res.end 'New Game'

exports.create = (req, res) ->
  res.end 'Create Game'

exports.show = (req, res) ->
  res.end 'Show Game'

exports.edit = (req, res) ->
  res.end 'Edit game'

exports.update = (req, res) ->
  res.end 'Update game'

exports.destroy = (req, res) ->
  res.end 'Destroy game'
