
require './init.rb'
require 'sinatra'
require 'thin'

class MyApp < Sinatra::Base
  def say_hello
    "hello, world!"
  end

  get "/" do
    say_hello
  end
end

begin
  thr = Thread.new { MyApp.run!(:server => 'thin') }
  
  puts "visit localhost:4567, observe ''hello, world!'"
  gets
  
  MyApp.define_instance_method_from_string(:say_hello, "'hello, again!'")
  
  puts "visit localhost:4567, observer 'hello, again!'"
  gets

rescue
  thr.exit
ensure
  thr.exit
end

