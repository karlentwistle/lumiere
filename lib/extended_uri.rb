module Lumiere
  module ExtendedURI
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def schemeless_parse(url)
        uri = URI.parse(url)
        uri = URI.parse("http://#{url}") if uri.scheme.nil?
        uri
      end
    end

    def schemeless_parse(url)
      uri = URI.parse(url)
      uri = URI.parse("http://#{url}") if uri.scheme.nil?
      uri
    end
  end
end
