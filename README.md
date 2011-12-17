Das Catalog
===========

The Das Catalog gem - used for downloading screencasts from the [Destroy All Software screencasts catalog](https://www.destroyallsoftware.com/screencasts).  Uses the rss feed plus Mechanize to log you in and then download unsaved movies to a local directory.

This gem is in not linked to Destroy All Software or endorsed by Gary Bernhardt.  I just like his stuff.

Requirements
------------

I've written and only run the gem on Ruby 1.9.2.  YMMV, but 1.8.x will definitely blow up.

The gem also expects that wget exists in your path, as it uses it for downloaded the movie file.

Installation
------------

Install the gem

    $ gem install das_catalog

Usage
-----

Run from the command line:

    $ das_catalog_sync

It will prompt your for some settings (username, password, storage directory) and then be off and running.

Stored Configuration
--------------------

If you don't provide configuration, `das_catalog_sync` will prompt you for configuration values when you run it.

However, you can persist a full or partial config in ~/.das_catalog.yml as such:

    ---
    username: your_username
    password: your_password
    downloads_directory: /Users/programmer/Movies/DAS

If you wish to exclude any config, leave it out and `das_catalog_sync` will prompt your for it at runtime.

Basic Process
-------------

The steps by which the gem works are fairly simple:

  1. Fetch the rss feed to see what is in the catalog
  2. Use Mechanize to log in at the DAS sign in page
  3. Find links in the feed that have not been downloaded yet
  4. Construct a download link, and grab the location header from the redirect (the movie on S3)
  5. Offload the download to wget for efficient processing

TODO
----
  * Finish missing spec coverage (mostly in DasCatalog toplevel namespace)
  * Hook up Aruba for bin testing
  * Switch bin to [GLI](https://github.com/davetron5000/gli)?
  * CLI interface for tracking if you've watched a specific screencast
  * Make missing directory automatically
  * better wget detection/warnings
  * Lighten some dependencies (feed fetching, highline, etc)
  * Better cli access to modify the underlying pstore
