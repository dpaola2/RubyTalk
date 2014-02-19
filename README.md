RubyTalk
========

[Here is the original slide deck](https://docs.google.com/presentation/d/14CCKIB5iXrKT98HmsTGJHgk6ceFDPNabcDzhj25qvmY/edit?usp=sharing)

RubyTalk's goal is to provide an interactive, visual programming environment, much like Smalltalk or Self. Build your applications by interacting directly with objects in memory, rather than their textual representation on the filesystem.

The larger goal is to think in higher-level abstractions than we currently have.

While a better mechanism for interacting with both definitions and instances is desirable, when it comes to sharing and saving, we're concerned (in the short term) only with sharing and saving definitions. We still want an environment with both, but saving and sharing instances of objects is a much hairier problem, however awesome it could be to have them.

The visualizations we use will constrain how we think about our objects and programs. Therefore we must choose carefully!

Status
======

Please note this project is PRE ALPHA. Not ready for even personal use!

# Roadmap

1. Inspector
2. Workspace improvements
  - print vs do
  - local bindings for lifetime of workspace
3. Observer pattern in GUI
4. Persistent Data
  - ability to store data in postgres and retrieve it
5. Web Framework
  - run servers in background threads
  - views render using HAML
  - pull in activerecord for ORM support
  - how to map routes onto functionality
    - controllers?
    - RESTful?
6. Object memory modifications
  - support for instances and modules
  - seralization overhaul
    - on open/close
    - store in postgres or somewhere sensible
    - open files, network connections
  - resolving dependencies and superclasses
  - multiple users
  - transactions
7. Debugging modifications
  - resumable exceptions
  - exceptions in other threads
8. Process Handling (threads)
9. Better GUI toolkit

# TODO

- local bindings in a workspace
- generate a docset for Dash (using [this guide](http://kapeli.com/docsets))
- exception handling from threads

# Ideas for applications / objects

- jarvis
- craigslist notifier (upon new search results)
- hipchat
- os x menubar applet (workspaces in smalltalk)
- hubot
- notifications when someone re-pushes to a pull request


How To Install
=============

(only tested on OS X 10.9.1)

[Download the community edition of ActiveTcl](http://www.activestate.com/activetcl)

```
$ rvm install 2.1.0 --with-pthread --with-tcl --with-tk

$ gem install bundler

$ brew install portaudio

$ brew install mpg123

$ bundle install

$ ./world.rb

```

After you close the GUI, `exit` will quit RubyTalk.


## Links

[Eigenclasses demystified](http://madebydna.com/all/code/2011/06/24/eigenclasses-demystified.html)

[Ruby TK Guide](http://www.tutorialspoint.com/ruby/ruby_tk_guide.htm)

[Ruby ObjectSpace heap dumper](http://tmm1.net/ruby21-objspace/)

