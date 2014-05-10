require_relative 'representer'
require_relative '../../provider'

module Lumiere
class YouTube < Provider
  attr_accessor :url
  include EmbedCode

  USEABLE = ['www.youtube.com', 'youtube.com', 'youtu.be']

  def self.useable?(url)
    uri = URISchemeless.parse(url)
    USEABLE.include?(uri.host)
  end

  def self.new_from_video_id(video_id, fetched=nil)
    new("http://www.youtube.com/watch?v=#{video_id}")
  end

  def initialize(url, fetched=nil)
    @url = url
    @fetched = fetched
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
    "//www.youtube.com/embed/#{video_id}"
  end

  def default_attributes
    { iframe_attributes:
      {
        frameborder: 0,
        allowfullscreen: true
      }
    }
  end

  def thumbnail_small
    fetch.thumbnails[0].url
  end

  def thumbnail_medium
    fetch.thumbnails[1].url
  end

  def thumbnail_large
    fetch.thumbnails[2].url
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

  def unpack_into
    struct = OpenStruct.new
    struct.extend(YouTubeVideoEntryRepresenter)
  end

  private

  def fetch
    @fetch ||= Fetcher.remote_attributes(api_url, unpack_into)
  end

  def calculate_video_id
    uri = URISchemeless.parse(url)
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
