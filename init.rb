

# Usage:
# Object.define_method_from_string(:foobar, "|name| @name = 'Dave'")
# o = Object.new
# o.method_list
# Object.instance_method_list

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
end
