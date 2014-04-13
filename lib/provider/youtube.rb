module Lumiere
class YouTube < Provider
  attr_accessor :url

  def self.useable?(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    case uri.host
    when 'www.youtube.com'
      true
    when 'youtube.com'
      true
    when 'youtu.be'
      true
    end
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
    @remote_structure ||= Lumiere::RemoteResponse.new(api_url, JSON).parse
  end

  def fetch_video_id
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    if uri.query
      uri.query.sub("v=", '')
    else
      uri.path.delete('/')
    end
  end

end
end
