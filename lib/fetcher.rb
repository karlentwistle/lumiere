require 'open-uri'

module Lumiere
  module Fetcher
    extend self

    def remote_attributes(api_url, unpack_into)
      body = scrape(api_url)
      unpack(body, unpack_into)
    end

    private

    def unpack(body, unpack_into)
      unpack_into.from_json(body)
    end

    def scrape(url)
      body = open(url).read
      body
    end

  end
end
