#! /usr/bin/env ruby

require 'debugger'

begin
  require './init.rb'
rescue Exception => e
  puts e.backtrace
  debugger
end
require 'irb'
IRB.setup nil
IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context
require 'irb/ext/multi-irb'
IRB.irb nil, self
