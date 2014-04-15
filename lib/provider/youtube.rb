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
    fetch['entry']['title']['$t']
  end

  def description
    fetch['entry']['media$group']['media$description']['$t']
  end

  def duration
    fetch['entry']['media$group']['yt$duration']['seconds'].to_i
  end

  def thumbnail_small
    fetch['entry']['media$group']['media$thumbnail'][0]['url']
  end

  def thumbnail_medium
    fetch['entry']['media$group']['media$thumbnail'][1]['url']
  end

  def thumbnail_large
    fetch['entry']['media$group']['media$thumbnail'][2]['url']
  end

  private

  def fetch
    @remote_structure ||= Lumiere::FetchParse.new(api_url, JSON).parse
  end

  def fetch_video_id
    uri = schemeless_parse(url)
    if uri.query
      uri.query.sub("v=", '')
    else
      uri.path.delete('/')
    end
  end

end
end
