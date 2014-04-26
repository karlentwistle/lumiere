module Lumiere
class Fetcher

  attr_accessor :fetched

  def initialize(api_url, unpack_into)
    @api_url = api_url
    @unpack_into = unpack_into
    @fetched = fetch
  end

  private

  def fetch
    @unpack_into.from_json(raw_response)
  end

  def raw_response
    open(@api_url).read
  end

end
end
