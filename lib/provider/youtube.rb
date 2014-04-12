class YouTube < Lumiere::Provider
  attr_accessor :id

  def self.useable?(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    uri.host == 'www.youtube.com' || 'youtube.com' || 'youtu.be'
  end

  def initialize(id)
    @id = id
  end

  def api_url
    "http://gdata.youtube.com/feeds/api/videos/#{@id}?v=2&alt=json"
  end

  def embed_url
    "http://www.youtube.com/embed/#{id}"
  end

  def embed_code
    "<iframe src=\"//www.youtube.com/embed/#{id}\" frameborder=\"0\" allowfullscreen></iframe>"
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
end
