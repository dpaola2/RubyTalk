
# See test.rb for usage details

Class.class_eval do
  define_method :define_instance_method_from_string do |name, proc_string|
    block = eval("lambda {#{ proc_string }}")
    define_method name.to_sym, block
    instance_method_list[name.to_sym] = proc_string
    block
  end

  define_method :instance_method_list do
    if @instance_method_list.nil?
      @instance_method_list = {}
    end
    @instance_method_list
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
  result.sort {|x, y| x.name <=> y.name }
end

def all_modules
  result = []
  ObjectSpace.each_object(Module) do |obj|
    result << obj
  end
  result.sort {|x, y| x.name <=> y.name }
end
