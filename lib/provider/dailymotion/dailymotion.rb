require_relative 'representer'
require_relative '../../provider'

module Lumiere
class Dailymotion < Provider
  attr_accessor :url
  include EmbedCode

  USEABLE = ['www.dailymotion.com', 'dailymotion.com']

  def self.useable?(url)
    uri = URISchemeless.parse(url)
    USEABLE.include?(uri.host)
  end

  def initialize(url)
    @url = url
  end

  def provider
    "Dailymotion"
  end

  def video_id
    @video_id ||= calculate_video_id
  end

  def api_url
    "https://api.dailymotion.com/video/#{video_id}?fields=id,title,description,duration,created_time,url,thumbnail_720_url,thumbnail_240_url,thumbnail_60_url"
  end

  def embed_url
    "//www.dailymotion.com/embed/video/#{video_id}"
  end

  def default_attributes
    {
      iframe_attributes: {
        frameborder: 0,
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
    struct = OpenStruct.new
    struct.extend(DailymotionVideoRepresenter)
  end

  private

  def fetch
    @fetch ||= Fetcher.remote_attributes(api_url, unpack_into)
  end

  def calculate_video_id
    uri = URISchemeless.parse(url)
    uri.path.gsub!('/embed/video/', '')
    uri.path.gsub!('/video/', '')
    uri.path.delete!('/')
    uri.path.split('_')[0]
  end

end
end
