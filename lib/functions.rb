def my_require(name)
  record_require(name)
  require name
end

def create_class(name, superclass)
  if superclass.nil?
    superclass = Object
  end
  Object.const_set(name, Class.new(superclass))
  record_class_change(name, superclass.to_s)
  return eval(name)
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
  classes = classes_from_disk
  classes << [class_name, superclass_name]
  classes.uniq!
  classes_to_disk(classes)
end

def classes_from_disk
  filepath = "classes.json"
  classes = []
  if File.exists? filepath
    classes = JSON.parse(File.open(filepath, "r").read())['classes']
  end
  classes
end

def classes_to_disk(classes)
  filepath = "classes.json"
  File.open(filepath, "w") do |f|
    f.write(JSON.pretty_generate({'classes'=> classes}))
  end
end

def record_class_delete(klass)
  classes = classes_from_disk
  classes.delete([klass.name, klass.superclass.name])
  classes.uniq!
  classes_to_disk(classes)
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
      puts "Creating class: #{name} with superclass #{superclass}"
      if superclass.nil?
        superclass = Object
      else
        superclass = eval(superclass)
      end
      
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
        klass = eval(class_name)
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
        klass = eval(class_name)
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
