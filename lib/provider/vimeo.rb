class Vimeo < Lumiere::Provider
  attr_accessor :id

  def self.usable?(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    uri.host == 'www.vimeo.com' || 'vimeo.com'
  end

  def initialize(id)
    @id = id
  end

  def api_url
    "http://vimeo.com/api/v2/video/#{id}.json"
  end

  def embed_url
    "http://player.vimeo.com/video/#{id}"
  end

  def embed_code
    "<iframe src=\"//player.vimeo.com/video/#{id}\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
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
end
