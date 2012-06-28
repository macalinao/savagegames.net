reports = require '../lib/reports'

module.exports =
  index: (req, res) ->
    report = req.body
    unless report
      res.render '404.jade', status: 404

    unless report.secret
      res.send '401 Unauthorized noob detected', 401

    reports.parse report, (err, game) ->
      return res.send('500 Could not parse report due to error: ' + err.toString() + '\n', 500) if err

      game.save (err) ->
        return res.send('Could not save due to error: ' + err.toString() + '\n') if err
        res.send 'WIN'
