RubyTalk
========

[Here is the original slide deck](https://docs.google.com/presentation/d/14CCKIB5iXrKT98HmsTGJHgk6ceFDPNabcDzhj25qvmY/edit?usp=sharing)

RubyTalk's goal is to provide an interactive, visual programming environment, much like Smalltalk or Self. Build your applications by interacting directly with objects in memory, rather than their textual representation on the filesystem.

The larger goal is to think in higher-level abstractions than we currently have.

Status
======

Please note this project is PRE ALPHA. Not ready for even personal use!

# TODO

- ~~support for classes~~
- ~~support for methods~~
- support for modules
- support for instances
- ~~search (for module/class names, or things that appear within code)~~
- delete objects & instances
- ~~GUI (shoes? morphic? X11? qt? Gtk+? web app?)~~
- better format for serialization
- serialize on world open/close, rather than object changes (hooks?)
- Rails-like web framework
- multi-user? How would that work?
- welcome message
- ~~organize the init.rb code into something sensible (like RubyTalk module)~~
- how to serialize open files and network connections
- resolve class superclasses upon definition (if we try to define a class with a nonexistant superclass, what happens?)
- how to handle cascading?
- make `Object` class receive the message `subclass` instead of using `create_class`
- resumable exceptions?
- Ruby threads === Smalltalk processes? (not yet)
- handle dependencies from within RubyTalk (rather than needing to edit the Gemfile and run bundle install)
- ability to bookmark classes in the system browser
- ~~pull RubyTalkGUI code into RubyTalk (instead of in gui.rb)~~
- use postgres as the object memory (to allow collaboration, and client/server-like architecture) (who needs icloud?)
- bookmarks for classes
- inspector so that messages can be sent to instances (explorer?)
- local bindings in a workspace
- generate a docset for Dash (using [this guide](http://kapeli.com/docsets))

# Ideas for applications / objects

- jarvis
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

