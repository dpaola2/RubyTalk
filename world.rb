#! /usr/bin/env ruby

require './init.rb'
require 'irb'
IRB.setup nil
IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context
require 'irb/ext/multi-irb'
IRB.irb nil, self
