API for the Rock & Roll Ember.js application
============================================

A simple REST API written for the Ember.js application I'm building in my “Build an Ember app” screencast series.

### Usage

1. Run `ruby db/tables.rb` to create the tables in the (sqlite) database.
2. Run `ruby db/seed.rb` to insert a few artists and songs in the database.
3. Run `rackup -p 9393` in the root folder of the application. (Running it on 9393 is only necessary so that you don't have to modify the urls in [the client](https://github.com/balinterdi/rock-and-roll). 

The source code for the client-side application can be found [here](https://github.com/balinterdi/rock-and-roll).

### Want more Ember stuff?

You can sign up to [the Ember.js mailing list](http://emberjs.balinterdi.com) to see the screencast series in which I 
build the app step by step and also get Ember.js related articles, best practices tips and other screencasts.

Copyright (c) 2013 [Balint Erdi](http://balinterdi.com)
