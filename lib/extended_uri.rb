require 'open-uri'

module Lumiere
  module URISchemeless
    def self.parse(url)
      url = url[2..-1] if url[0..1] == '//' # TODO: make this better
      uri = URI.parse(url)
      uri = URI.parse("http://#{url}") unless uri.absolute?
      uri
    end
  end
end
