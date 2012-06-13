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

module.exports =
  show: (req, res) ->
    res.render 'classes.jade',
      classes: classes
