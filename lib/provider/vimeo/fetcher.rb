module Lumiere
class Fetcher

  attr_accessor :fetched

  def initialize(api_url, &block)
    @api_url = api_url
    @representer = block.call
    @fetched = fetch
  end

  private

  def fetch
    videos = [].extend(@representer)
    videos.from_json(raw_response)
  end

  def raw_response
    open(@api_url).read
  end

end
end
