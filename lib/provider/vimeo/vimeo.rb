module Lumiere
class Vimeo < Provider
  attr_accessor :url

  USEABLE = ['www.vimeo.com', 'vimeo.com', 'player.vimeo.com']

  def self.useable?(url)
    uri = URISchemeless.parse(url)
    USEABLE.include?(uri.host)
  end

  def self.new_from_video_id(video_id)
    new("http://vimeo.com/#{video_id}")
  end

  def initialize(url=nil)
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
    fetch! unless @title
    @title
  end

  def description
    fetch! unless @description
    @description
  end

  def duration
    fetch! unless @duration
    @duration
  end

  def upload_date
    fetch! unless @upload_date
    @upload_date
  end

  def thumbnail_small
    fetch! unless @thumbnail_small
    @thumbnail_small
  end

  def thumbnail_medium
    fetch! unless @thumbnail_medium
    @thumbnail_medium
  end

  def thumbnail_large
    fetch! unless @thumbnail_large
    @thumbnail_large
  end

  private

  attr_writer :title, :description, :upload_date, :thumbnail_small, :thumbnail_medium, :thumbnail_large, :video_id, :duration

  def fetch!
    data = MultiJson.load(raw_response)[0]
    self.extend(VimeoVideoRepresenter).from_hash(data)
  end

  def calculate_video_id
    uri = URISchemeless.parse(url)
    uri.path.gsub!('/video/', '')
    uri.path.delete!('/')
    uri.path
  end

end
end
