
require './init.rb'
require 'pp'

class Foo
end

modules = all_modules

puts "Found #{modules.count}  modules:"
pp modules

puts "Selecting the Foo module:"
foo_class = modules[modules.index(Foo)]
pp foo_class.inspect

puts "Defining name= on Foo:"
foo_class.define_instance_method_from_string(:name=, "|name| @name = name")
puts "Instance method list for Foo:"
pp foo_class.instance_method_list

puts "Adding a name attribute"
f = foo_class.new
f.name = "dave"
puts "Instance of foo now looks like:"
pp f.method_list

puts "Defining a name accessor:"
foo_class.define_instance_method_from_string(:name, "@name")
puts "Instance method list for foo now looks like:"
pp f.method_list
puts "Which matches the instance method list for the class Foo:"
pp foo_class.instance_method_list


