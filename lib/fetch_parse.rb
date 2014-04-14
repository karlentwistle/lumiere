module Lumiere
  class FetchParse
    def initialize(url, parser)
      @url = url
      @parser = parser
    end

    def parse
      @parser.parse(raw_response)
    end

    private

    def raw_response
      open(@url).read
    end

  end
end
