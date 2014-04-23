module Lumiere
class YouTube < Provider
  include ExtendedURI
  attr_accessor :url

  USEABLE = ['www.youtube.com', 'youtube.com', 'youtu.be']

  def self.useable?(url)
    uri = schemeless_parse(url)
    USEABLE.include?(uri.host.to_s)
  end

  def self.new_from_video_id(video_id)
    new("http://www.youtube.com/watch?v=#{video_id}")
  end

  def initialize(url)
    @url = url
  end

  def provider
    "YouTube"
  end

  def video_id
    @video_id ||= calculate_video_id
  end

  def api_url
    "http://gdata.youtube.com/feeds/api/videos/#{video_id}?v=2&alt=json"
  end

  def embed_url
    "http://www.youtube.com/embed/#{video_id}"
  end

  def embed_code
    "<iframe src=\"//www.youtube.com/embed/#{video_id}\" frameborder=\"0\" allowfullscreen></iframe>"
  end

  def thumbnail_small
    fetch! unless defined?(@thumbnails)
    @thumbnails[0].url
  end

  def thumbnail_medium
    fetch! unless defined?(@thumbnails)
    @thumbnails[1].url
  end

  def thumbnail_large
    fetch! unless defined?(@thumbnails)
    @thumbnails[2].url
  end

  REMOTE_ATTRIBUTES = [:title, :description, :duration, :upload_date]

  REMOTE_ATTRIBUTES.each do |attribute|
    define_method(attribute) do
      fetch! unless instance_variable_get("@#{attribute}")
      instance_variable_get("@#{attribute}")
    end
  end

  private

  REMOTE_ATTRIBUTES.each do |attribute|
    attr_writer attribute
  end

  attr_writer :thumbnails

  def fetch!
    self.extend(YouTubeVideoRepresenter).from_json(raw_response)
  end

  def calculate_video_id
    uri = schemeless_parse(url)
    if uri.query
      params_hash = Hash[URI::decode_www_form(uri.query)]
      params_hash['v']
    else
      uri.path.gsub!('/embed/', '')
      uri.path.gsub!('/v/', '')
      uri.path.gsub!('/e/', '')
      uri.path.delete!('/')
      uri.path
    end
  end

end
end
