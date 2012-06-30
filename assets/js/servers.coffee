$ ->
  $.getJSON '/api/ping_servers.json', (data) ->
    for ping, i in data
      outer = $('<div>').addClass('span2')
      well = $('<div/>').addClass('well')
        .css('min-height', '72px')
        .attr('data-index', i)

      serverName = $('<div/>').css(
        'font-weight': 'bold'
        'font-size': '12pt'
        'white-space': 'nowrap'
      ).html ping.server

      well.append serverName
      outer.append well

      $('#servers').append outer
      $('#starting-soon').append outer.clone()
      $('#queued').append outer.clone()

    update data

update = (data) ->
  if data isnt null
    draw data
  else
    $.getJSON '/api/ping_servers.json',
      NoCache: new Date().getTime()
    , (data) ->
      draw data

  setTimeout update, 5000

draw = (data) ->
  ###
  Draws the server list.
  ###
  players = 0
  i = 0

  for ping, i in data 
    inProgress = ping.MOTD.indexOf('In progress.') isnt -1

    continue if ping.Server.indexOf('mc-hg') is -1
    
    players += ping.Players
    well = $('[data-index=' + i + ']')
    well.html ''
    well.append $('<div/>').css(
      'font-weight': 'bold'
      'font-size': '12pt'
      'white-space': 'nowrap'
    ).html(ping.Server)
    
    # Check for server online
    unless ping.online
      well.append '<div>QUEUED - Waiting for my turn to start up</div>'
    else
      well.css 'border', 'solid 1px black'
      well.append $('<div>').text(ping.players + '/' + ping.max_players + ' - ' + ping.ping_length + 'ms')
      if inProgress
        well.append $('<div>').text('Game in progress')
      else
        well.append $('<div>').text(ping.MOTD)
        well.hide()
    
    if not inProgress and ping.online
      $('[data-index=' + i + ']', $('#starting-soon')).show()
    else unless ping.IsOnline
      $('[data-index=' + i + ']', '#queued').show()
    else
      $('[data-index=' + i + ']', $('#servers')).show()

  $('#player-count').text players
