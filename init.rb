require 'bundler/cli'
require 'json'
require 'debugger'
require './lib/functions.rb'
require './lib/ruby_talk.rb'


def welcome
  puts "Bootstrapping environment..."
  RubyTalk.bootstrap
  puts "Loading changes from classes.json and methods.json..."
  load_changes
  puts "Done."
  puts ""
  puts "### WELCOME TO RUBYTALK ###"
  puts ""
end

welcome()
  
