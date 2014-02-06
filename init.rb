require 'bundler/cli'
require 'json'
require 'debugger'
require './lib/functions.rb'
require './lib/ruby_talk.rb'
require './lib/gui.rb'


def welcome
  Thread.current[:name] = "Main"
  puts "Bootstrapping environment..."
  RubyTalk.bootstrap
  puts "Loading changes from classes.json and methods.json..."
  RubyTalk.set_global_state(load_changes)
  puts "Done."
  puts ""
  puts "### WELCOME TO RUBYTALK ###"
  puts ""
  @@gui = RubyTalkGUI.new
  Tk.mainloop
end

welcome()
  
