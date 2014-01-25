module RubyTalk
  def self.bootstrap
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

      define_method :delete do
        record_class_delete(self)
        Object.send(:remove_const, self.name.to_sym)
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
  end
end
