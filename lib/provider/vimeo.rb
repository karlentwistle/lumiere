module Lumiere
class Vimeo < Provider
  attr_accessor :url

  USEABLE = ['www.vimeo.com', 'vimeo.com']

  def self.useable?(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
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
    fetch[0]['title']
  end

  def description
    fetch[0]['description']
  end

  def duration
    fetch[0]['duration']
  end

  def thumbnail_small
    fetch[0]['thumbnail_small']
  end

  def thumbnail_medium
    fetch[0]['thumbnail_medium']
  end

  def thumbnail_large
    fetch[0]['thumbnail_large']
  end

  private

  def fetch
    @remote_structure ||= Lumiere::RemoteResponse.new(api_url, JSON).parse
  end

  def fetch_video_id
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    uri.path.delete('/')
  end
end
end
