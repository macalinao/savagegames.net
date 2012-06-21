misc = require '../lib/misc'

classes =
  'Warrior':
    desc: 'Starts out with a stone sword.'
    vid: 'uLghhGPiF-s'
  'Archer':
    desc: 'Test123.'
    vid: 'uLghhGPiF-s'
  'Other':
    desc: 'Test1asdasd23.'
    vid: 'uLghhGPiF-s'
  'anOther':
    desc: 'st1anananananaasdasd23.'
    vid: 'uLghhGPiF-s'

# Placeholders
freeClasses = ['Warrior', 'Archer', 'Other', 'anOther']
paidClasses = ['Warrior', 'Archer', 'Other', 'anOther']

misc.matrixify freeClasses, 3
misc.matrixify paidClasses, 3

module.exports =
  index: (req, res) ->
    res.render 'classes.jade',
      classes: classes
