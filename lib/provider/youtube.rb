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

  def video_id
    @video_id ||= fetch_video_id
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
    @raw ||= open(api_url).read
  end

  def fetch
    @fetch ||= OpenStruct.new.extend(VideoRepresenter).from_json(raw_response)
  end

  def fetch_video_id
    uri = schemeless_parse(url)
    if uri.query
      uri.query.sub("v=", '')
    else
      uri.path.delete('/')
    end
  end

  module VideoRepresenter
    include Representable::JSON
    self.representation_wrap = :entry

    nested 'title' do
      property :title, as: '$t'
    end

    nested 'media$group' do
      nested 'media$description' do
        property :description, as: '$t'
      end

      nested 'yt$duration' do
        property :duration, as: :seconds
      end

      nested 'media$thumbnail' do
        property :thumbnail_small, :reader => lambda { |doc, args| self.thumbnail_small = doc[0]['url'] }
        property :thumbnail_medium, :reader => lambda { |doc, args| self.thumbnail_medium = doc[1]['url'] }
        property :thumbnail_large, :reader => lambda { |doc, args| self.thumbnail_large = doc[2]['url'] }
      end
    end
  end


end
end
