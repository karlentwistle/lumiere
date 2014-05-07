module Lumiere
  module EmbedCode
    extend self

    def embed_code(opts = {})
      iframe_attributes = opts.fetch(:iframe_attributes, {})
      options = default_attributes.merge(iframe_attributes)
      Lumiere::EmbedCode.generate(embed_url, options)
    end

    def generate(src, opts={})
      opts ||= {}
      opts = {src: src}.merge(opts)

      generate_html_object('iframe', opts)
    end

    private

    def generate_html_object(object_name, opts)
      html_options = generate_object_properties(opts)
      "<#{object_name} #{html_options}></#{object_name}>"
    end

    def generate_object_properties(opts={})
      opts.map do |key, value|
        generate_object_property(key, value)
      end.join(' ')
    end

    def generate_object_property(key, value)
      if value.is_a?(TrueClass)
        key #set as 'option' rather than 'option=true'
      else
        "#{key}=\"#{value}\""
      end
    end
  end
end
