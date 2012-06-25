exports.matrixify = (arr, cols) ->
  ###
  Turns an array into a matrix with the given number of columns.
  ###
  matrix = []
  matrix.push arr[i..(i + cols - 1)] for i in [0..arr.length - 1] by cols
  return matrix

exports.getOrdinal = (n) ->
  ###
  Turns a number into its ordinal.
  ###
  s = ['th', 'st', 'nd', 'rd']
  v = n % 100
  return n + (s[(v - 20) % 10] || s[v] || s[0])
