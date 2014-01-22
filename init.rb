require 'bundler/cli'
require 'json'
require 'debugger'

# See test.rb for usage details

def my_require(name)
  record_require(name)
  require name
end


def create_class(name, superclass=Object)
  Object.const_set(name, Class.new(superclass))
  record_class_change(name, superclass.to_s)
  return Kernel.const_get(name)
end

Class.class_eval do
  define_method :define_instance_method_from_string do |name, proc_string|
    block = eval("lambda {#{ proc_string }}")
    define_method name.to_sym, block
    instance_method_list[name.to_sym] = proc_string
    record_method_change(self.name, name, proc_string)
    block
  end

  define_method :instance_method_list do
    if @instance_method_list.nil?
      @instance_method_list = {}
    end
    @instance_method_list
  end

  define_method :define_class_method_from_string do |name, proc_string|
    block = eval("lambda {#{ proc_string }}")
    self.class.instance_eval do
      define_method name.to_sym, block
    end
    class_method_list[name.to_sym] = proc_string
    record_class_method_change(self.name, name, proc_string)
    block
  end

  define_method :class_method_list do
    if @class_method_list.nil?
      @class_method_list = {}
    end
    @class_method_list
  end
end

Object.class_eval do
  define_method :method_list do
    self.class.instance_method_list
  end

  define_method :descendants do
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end

def all_classes
  result = []
  ObjectSpace.each_object(Class) do |obj|
    result << obj
  end
  result
end

def all_modules
  result = []
  ObjectSpace.each_object(Module) do |obj|
    result << obj
  end
  result
end

def find_my_objects
  results = []
  ObjectSpace.each_object do |obj|
    if obj.methods.index(:instance_method_list) != nil
      results << obj
    end
  end
  results
end

def record_require(name)
  filepath = "requires.json"
  requires = []
  if File.exists? filepath
    requires = JSON.parse(File.open(filepath, "r").read())['requires']
  end

  requires << name
  requires.uniq!
  File.open(filepath, "w") do |f|
    f.write(JSON.pretty_generate({'requires' => requires}))
  end
end

def record_class_change(class_name, superclass_name)
  filepath = "classes.json"
  classes = []
  if File.exists? filepath
    classes = JSON.parse(File.open(filepath, "r").read())['classes']
  end
  classes << [class_name, superclass_name]
  classes.uniq!
  File.open(filepath, "w") do |f|
    f.write(JSON.pretty_generate({'classes'=> classes}))
  end
end

def record_class_method_change(class_name, method_name, proc_string)
  filepath = "class_methods.json"
  changes = {}
  if File.exists? filepath
    changes = JSON.parse(File.open(filepath, "r").read())
  end

  if changes[class_name.to_s].nil?
    changes[class_name.to_s] = {}
  end
  changes[class_name.to_s][method_name] = proc_string

  File.open(filepath, "w") do |f|
    f.write(JSON.pretty_generate(changes))
  end
end

def record_method_change(class_name, method_name, proc_string)
  filepath = "methods.json"
  changes = {}
  if File.exists? filepath
    # read file, decode into hash
    file = File.open(filepath, "r")
    changes = JSON.parse(file.read)
  end
  
  # write new values to the hash
  if changes[class_name.to_s].nil?
    changes[class_name.to_s] = {}
  end
  changes[class_name.to_s][method_name] = proc_string
  
  # write the file
  File.open(filepath, "w") do |f|
    f.write(JSON.pretty_generate(changes))
  end
end

def load_changes
  filepath = 'requires.json'
  if File.exists? filepath
    requires = JSON.parse(File.open(filepath, "r").read())['requires']
    requires.each do |name|
      puts "require '#{name}'"
      require name
    end
  else
    puts "No requires.json found"
  end
  
  filepath = "classes.json"
  if File.exists? filepath
    classes = JSON.parse(File.open(filepath, "r").read())['classes']
    classes.each do |name, superclass|
      if superclass.nil?
        superclass = Object
      else
        superclass = Kernel.const_get(superclass)
      end
      
      puts "Creating class: #{name} with superclass #{superclass}"
      create_class(name, superclass)
    end
  else
    puts "No classes.json found"
  end

  filepath = "class_methods.json"
  if File.exists? filepath
    changes = JSON.parse(File.open(filepath, "r").read())
    classes = changes.keys
    classes.each do |class_name|
      methods = changes[class_name].keys
      methods.each do |method_name|
        klass = Kernel.const_get(class_name.to_sym)
        puts "Defining #{method_name} CLASS method on class: #{class_name}"
        klass.define_class_method_from_string(method_name.to_s, changes[class_name][method_name])
      end
    end
  else
    puts "No class_methods.json found"
  end

  filepath = "methods.json"
  if File.exists? filepath
    changes = JSON.parse(File.open("methods.json", "r").read())
    classes = changes.keys
    classes.each do |class_name|
      methods = changes[class_name].keys
      methods.each do |method_name|
        klass = Kernel.const_get(class_name.to_sym)
        puts "Defining #{method_name} on class: #{class_name}..."
        klass.define_instance_method_from_string(method_name.to_s, changes[class_name][method_name])
      end
    end
  else
    puts "No methods.json found"
  end
end

def class_exists?(class_name)
  klass = Module.const_get(class_name)
  return klass.is_a?(Class)
rescue NameError
  return false
end

def bundle_install
  Bundler::CLI.new.install
end

def main
  puts "Installing dependencies..."
  bundle_install

  puts "Loading changes from classes.json and methods.json..."
  load_changes
  puts "Done."
end

main()
