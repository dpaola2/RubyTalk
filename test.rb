
require './init.rb'

class Foo
end

Foo.define_instance_method_from_string(:name=, "|name| @name = name")
f = Foo.new
f.name = "dave"

Foo.define_instance_method_from_string(:name, "@name")
puts f.name

puts "Foo.instance_method_list: #{Foo.instance_method_list.inspect}"
puts "f.method_list: #{f.method_list.inspect}"

