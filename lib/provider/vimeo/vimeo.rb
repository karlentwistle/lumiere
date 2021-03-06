require_relative 'representer'
require_relative '../../provider'

module Lumiere
class Vimeo < Provider
  attr_accessor :url
  include EmbedCode

  USEABLE = ['www.vimeo.com', 'vimeo.com', 'player.vimeo.com']

  def self.useable?(url)
    uri = URISchemeless.parse(url)
    USEABLE.include?(uri.host)
  end

  def self.new_from_video_id(video_id, fetched=nil)
    new("http://vimeo.com/#{video_id}", fetched)
  end

  def initialize(url, fetched=nil)
    @url = url
    @fetched = fetched
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
    "//player.vimeo.com/video/#{video_id}"
  end

  def default_attributes
    {
      iframe_attributes: {
        frameborder: 0,
        webkitallowfullscreen: true,
        mozallowfullscreen: true,
        allowfullscreen: true
      }
    }
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

  def unpack_into
    struct = []
    struct.extend(VimeoVideosRepresenter)
  end

  private

  def fetch
    @fetch ||= Fetcher.remote_attributes(api_url, unpack_into)[0]
  end

  def calculate_video_id
    uri = URISchemeless.parse(url)
    uri.path.gsub!('/video/', '')
    uri.path.delete!('/')
    uri.path
  end

end
end
