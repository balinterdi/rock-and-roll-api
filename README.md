API for the Rock & Roll Ember.js application
============================================

A simple REST API written for the Ember.js application I'm building in my “Build an Ember app” screencast series.

## Usage

### Run locally

1. Run `ruby db/tables.rb` to create the tables in the (sqlite) database.
2. Run `ruby db/seed.rb` to insert a few artists and songs in the database.
3. Run `bundle exec rerun 'DATABASE_URL=postgres://localhost/rock-and-roll rackup` in the root folder of the application (where DATABASE_URL points to the database you want to connect to). That will spin up the app on port 9292 that you can check by issuing a request to `http://localhost:9292`. You should see something like: 

    {"name":"Rock & Roll API","version":"0.1"}
    
If you wish to run it on another port, just append `-p <port>` to the above command.

### Don't have ruby or don't want to bother?

No problem, the API is available on [Heroku][heroku_host]. Just direct your client application to that URL. The ["official" client](https://github.com/balinterdi/rock-and-roll) is set up to do that, so once you clone it, it should just work.

The database will be reset (and reseeded with a handful of artists and songs) each night, at 01:00 UTC, so you have a fresh database to start the day with.

The source code for the client-side application can be found [here](https://github.com/balinterdi/rock-and-roll).

### Want more Ember stuff?

You can sign up to [the Ember.js mailing list](http://emberjs.balinterdi.com) to see the screencast series in which I
build the app step by step. You'll also get researched articles, best practice tips and smaller snacks each week.

Copyright (c) 2013-2014 [Balint Erdi](http://balinterdi.com)

[heroku_host]: http://rock-and-roll-with-emberjs-api.herokuapp.com/
