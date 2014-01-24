RubyTalk
========

[Here is the original slide deck](https://docs.google.com/presentation/d/14CCKIB5iXrKT98HmsTGJHgk6ceFDPNabcDzhj25qvmY/edit?usp=sharing)

RubyTalk's goal is to provide an interactive, visual programming environment, much like Smalltalk or Self. Build your applications by interacting directly with objects in memory, rather than their textual representation on the filesystem.

Status
======

Please note this project is PRE ALPHA. Not ready for even personal use!

# TODO

- ~~support for classes~~
- ~~support for methods~~
- support for modules
- support for instances
- delete objects & instances
- GUI (shoes? morphic? X11? qt? Gtk+? web app?)
- better format for serialization
- serialize on world open/close, rather than object changes (hooks?)
- Rails-like web framework
- multi-user? How would that work?
- welcome message
- organize the init.rb code into something sensible (like RubyTalk module)
- how to serialize open files and network connections
- resolve class superclasses upon definition (if we try to define a class with a nonexistant superclass, what happens?)

# Ideas for applications / objects

- jarvis
- hipchat
- os x menubar applet (workspaces in smalltalk)
- hubot
- 

How To Install
=============

`
$ rvm install 2.1.0

$ gem install bundler

$ brew install portaudio

$ brew install mpg123

$ bundle install

$ ./world.rb

`

`exit` will quit RubyTalk.
