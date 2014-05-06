require 'open-uri'

module Lumiere
class Fetcher

  def initialize(context)
    @api_url = context.api_url
    @unpack_into = context.unpack_into
  end

  def remote_attributes
    unless request_hash[@api_url]
      request_hash[@api_url] = unpack
    end
    request_hash[@api_url]
  end

  private

  def request_hash
    @request_hash ||= {}
  end

  def unpack
    @unpack_into.from_json(raw_response)
  end

  def raw_response
    open(@api_url).read
  end

end
end
