#! /usr/bin/env ruby

require 'debugger'

require './init.rb'

def drop_into_shell
  require 'irb'
  IRB.setup nil
  IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context
  require 'irb/ext/multi-irb'
  IRB.irb nil, self
end
