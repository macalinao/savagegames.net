exports.matrixify = (arr, cols) ->
  ###
  Turns an array into a matrix with the given number of columns.
  ###
  matrix = []
  matrix.push arr[i..(i + cols - 1)] for i in [0..arr.length - 1] by cols
  return matrix
