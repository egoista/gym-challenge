module BaseModel
  module AttributesType
    BASIC_TYPES = [String, Float, Integer, Time].freeze

    BASIC_TYPES.each do |type|
      define_method(type.name.downcase) do |attr_name|
        attribute(attr_name, type: type)
      end
    end

    def attribute(attr_name, type:)
      define_method attr_name do
        instance_variable_get("@#{attr_name}")
      end

      define_method "#{attr_name}=" do |value|
        if value.class.to_s != type.to_s
          self.class.argument_error(attr_name, type, value)
        end

        instance_variable_set("@#{attr_name}", value)
      end
    end

    def array(attr_name, type:)
      define_method attr_name do
        instance_variable_get("@#{attr_name}") || []
      end

      define_method "add_to_#{attr_name}" do |value|
        if value.class.to_s != type.to_s
          self.class.argument_error(attr_name, type, value)
        end

        instance_variable_set("@#{attr_name}", send(attr_name) + [value])
      end
    end

    define_method 'argument_error' do |attr_name, type, value|
      raise ArgumentError,
            "Expected a #{type} value for #{name}##{attr_name}, but got a #{value.class}"
    end
  end
end
