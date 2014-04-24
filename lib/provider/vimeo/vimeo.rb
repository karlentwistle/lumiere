module Lumiere
class Vimeo < Provider
  attr_accessor :url

  USEABLE = ['www.vimeo.com', 'vimeo.com', 'player.vimeo.com']

  def self.useable?(url)
    uri = URISchemeless.parse(url)
    USEABLE.include?(uri.host.to_s)
  end

  def initialize(url)
    @url = url
  end

  def provider
    "Vimeo"
  end

  def video_id
    @video_id ||= calculate_video_id
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
    fetch.duration
  end

  def upload_date
    fetch.upload_date
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

  def fetch
    @fetch ||= [].extend(VimeoVideosRepresenter).from_json(raw_response)[0]
  end

  def calculate_video_id
    uri = URISchemeless.parse(url)
    uri.path.gsub!('/video/', '')
    uri.path.delete!('/')
    uri.path
  end

end
end
