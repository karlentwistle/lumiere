class YouTube < Lumiere::Provider
  attr_accessor :id

  def self.usable?(url)
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

  REMOTE_MAP = {
    title: lambda { |rs| rs['entry']['title']['$t'] },
    description: lambda { |rs| rs['entry']['media$group']['media$description']['$t'] },
    duration: lambda { |rs| rs['entry']['media$group']['yt$duration']['seconds'].to_i },
    thumbnail_small: lambda { |rs| rs['entry']['media$group']['media$thumbnail'][0]['url'] },
    thumbnail_medium: lambda { |rs| rs['entry']['media$group']['media$thumbnail'][1]['url'] },
    thumbnail_large: lambda { |rs| rs['entry']['media$group']['media$thumbnail'][2]['url'] },
  }

  REMOTE_MAP.each do |meth_name, remote_location|
    define_method(meth_name) do
      fetch { |rs| remote_location.call(rs) }
    end
  end
end
