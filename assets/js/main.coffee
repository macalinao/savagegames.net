#= require jquery
#= require bootstrap

$ ->
  $('#search-players-form').submit ->
    console.log window.location = '/players/' + $('#search-players').val()
    return false
