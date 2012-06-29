fs = require 'fs'
config = require '../config/configwrapper'
mongoose = require 'mongoose'

###
Tests for lib/
###
describe 'lib/', ->
  before (done) ->
    mongoose.connect config.development.database
    require('../db/seeds') done

  describe 'misc', ->
    
    misc = require '../lib/misc'
    
    describe '#matrixify', ->
      it 'turns an array into a matrix', ->
        arr = [1, 2, 3, 4, 5, 6]
        res = misc.matrixify arr, 3
        res.toString().should.equal [[1, 2, 3], [4, 5, 6]].toString()

      it 'turns a weirdly-sized array into a matrix with missing elements', ->
        arr = [1, 2, 3, 4, 5, 6]
        res = misc.matrixify arr, 4
        res.toString().should.equal [[1, 2, 3, 4], [5, 6]].toString()

  describe 'reports', ->

    reports = require '../lib/reports'

    Server = require '../models/server'
    
    describe '#parse', ->
      it 'generates a Game', (done) ->
        fs.readFile 'test/docs/sample_report.json', 'utf8', (err, data) ->
          done err if err

          report = JSON.parse data

          reports.parse report, (err, game) ->

            Server.findById game.server, (err, server) ->
              server.secret.should.equal report.secret
              game.save (err) ->
                console.log err if err
                done()

  after (done) ->
    require('../db/trample') ->
      mongoose.disconnect done
