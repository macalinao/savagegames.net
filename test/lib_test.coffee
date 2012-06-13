###
Tests for lib/
###
misc = require '../lib/misc'
describe 'lib/misc', ->
  describe '#matrixify', ->
    it 'turns an array into a matrix', ->
      arr = [1, 2, 3, 4, 5, 6]
      res = misc.matrixify arr, 3
      res.toString().should.equal [[1, 2, 3], [4, 5, 6]].toString()

    it 'turns a weirdly-sized array into a matrix with missing elements', ->
      arr = [1, 2, 3, 4, 5, 6]
      res = misc.matrixify arr, 4
      res.toString().should.equal [[1, 2, 3, 4], [5, 6]].toString()
