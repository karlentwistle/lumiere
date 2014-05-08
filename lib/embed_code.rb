require_relative 'src'

module Lumiere
  module EmbedCode
    extend self

    def embed_code(opts = {})
      iframe_attributes = opts.fetch(:iframe_attributes, {})
      url_attributes = opts.fetch(:url_attributes, {})

      default_iframe_attributes = default_attributes.fetch(:iframe_attributes, {})
      default_url_attributes = default_attributes.fetch(:url_attributes, {})

      object_properties = default_iframe_attributes.merge(iframe_attributes)
      url_properties = default_url_attributes.merge(url_attributes)

      generate(embed_url, url_properties, object_properties)
    end

    private

    def generate(src, url_properties={}, object_properties={})
      src = src_encoder.encode(src, url_properties)
      object_properties = {src: src}.merge(object_properties)
      generate_html_object('iframe', object_properties)
    end

    def src_encoder
      SRC
    end

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
