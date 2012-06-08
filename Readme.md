SavageGames.net website
=======================

A Node.js/Express app created for Savage Games.

Features/should feature:
* RESTful API for communicating to servers and retrieving stats
* Paypal integration somehow
* Twitter Bootstrap in the form of Bootswatch
* Express.js awesomeness

Developing
==========

Use the following command:

```
make watch
```

This will compile your Coffeescript whenever something changes.

It's always nice to restart the server when you change something,
so I use `nodemon` for that. Just use:

```
npm install -g nodemon
nodemon index
```

to have a development server up and running, restarting when you change the tiniest file.

Building/Running
================

In the top directory, do:

```
make clean build test
node index
```

License
=======

Copyright (c) 2012 Ian Macalinao

This software is released under the Affero General Public License v3. Please see LICENSE.txt for details.
