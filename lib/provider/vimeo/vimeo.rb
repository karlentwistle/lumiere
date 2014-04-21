module Lumiere
class Vimeo < Provider
  include ExtendedURI
  attr_accessor :url

  USEABLE = ['www.vimeo.com', 'vimeo.com']

  def self.useable?(url)
    uri = schemeless_parse(url)
    USEABLE.include?(uri.host.to_s)
  end

  def initialize(url)
    @url = url
  end

  def video_id
    @video_id ||= fetch_video_id
  end

  def api_url
    "http://vimeo.com/api/v2/video/#{video_id}.json"
  end

  def embed_url
    "http://player.vimeo.com/video/#{video_id}"
  end

  def embed_code
    "<iframe src=\"//player.vimeo.com/video/#{video_id}\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
  end

  def title
    fetch.title
  end

  def description
    fetch.description
  end

  def duration
    fetch.duration.to_i
  end

  def thumbnail_small
    fetch.thumbnail_small
  end

  def thumbnail_medium
    fetch.thumbnail_medium
  end

  def thumbnail_large
    fetch.thumbnail_large
  end

  private

  def raw_response
    open(api_url).read
  end

  def fetch
    videos = [].extend(VimeoVideosRepresenter).from_json(raw_response)
    @fetch ||= videos[0]
  end

  def fetch_video_id
    uri = schemeless_parse(url)
    uri.path.delete('/')
  end

end
end
