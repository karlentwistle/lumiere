module Lumiere
class Fetcher

  def initialize(api_url, unpack_into)
    @api_url = api_url
    @unpack_into = unpack_into
  end

  def fetched
    @unpack_into.from_json(raw_response)
  end

  private

  def raw_response
    open(@api_url).read
  end

end
end
