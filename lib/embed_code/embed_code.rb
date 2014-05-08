require_relative 'src'
require_relative 'html_object_properties'

module Lumiere
  module EmbedCode
    extend self

    def embed_code(opts = {})
      src = generate_src(opts)
      object_properties = generate_object_properties(opts)

      generate_iframe(src, object_properties)
    end

    private

    def generate_src(opts = {})
      url_attributes = opts.fetch(:url_attributes, {})
      default_url_attributes = default_attributes.fetch(:url_attributes, {})
      url_properties = default_url_attributes.merge(url_attributes)
      src_encoder.(embed_url, url_properties)
    end

    def src_encoder
      SRC
    end

    def generate_object_properties(opts = {})
      iframe_attributes = opts.fetch(:iframe_attributes, {})
      default_iframe_attributes = default_attributes.fetch(:iframe_attributes, {})
      default_iframe_attributes.merge(iframe_attributes)
    end

    def generate_iframe(src, opts)
      opts = {src: src}.merge(opts)
      html_options = html_object_properties.(opts)
      "<iframe #{html_options}></iframe>"
    end

    def html_object_properties
      HTMLObjectProperties
    end
  end
end
