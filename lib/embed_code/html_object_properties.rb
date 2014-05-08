module Lumiere
  module HTMLObjectProperties
    extend self

    def generate(opts={})
      opts.map do |key, value|
        generate_object_property(key, value)
      end.join(' ')
    end

    private

    def generate_object_property(key, value)
      if value.is_a?(TrueClass)
        key #set as 'option' rather than 'option=true'
      else
        "#{key}=\"#{value}\""
      end
    end
  end
end
