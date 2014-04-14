module Lumiere
  module ExtendedURI
    def schemeless_parse(url)
      uri = URI.parse(url)
      uri = URI.parse("http://#{url}") if uri.scheme.nil?
      uri
    end
  end
end
