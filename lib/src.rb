require 'open-uri'

module Lumiere
  module SRC
    extend self

    def encode(src, opts={})
      src += www_form(opts) unless opts.empty?
      src
    end

    private

    def www_form(opts)
      "?" + uri.encode_www_form(opts)
    end

    def uri
      URI
    end
  end
end
