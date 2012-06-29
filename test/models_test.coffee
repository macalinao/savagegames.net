fs = require 'fs'
config = require '../config/configwrapper'
mongoose = require 'mongoose'

###
Tests for models/
###
describe 'lib/', ->
  before (done) ->
    mongoose.connect config.development.database
    require('../db/seeds') done

  describe 'player', ->

    Player = require '../models/player'

    describe '#getPlayer', ->

      it 'should create a player if it doesn\'t exist', (done) ->

        Player.getPlayer 'RandomPlayer', (err, player) ->
          player.name.should.equal 'RandomPlayer'
          done()

  after (done) ->
    require('../db/trample') ->
      mongoose.disconnect done
