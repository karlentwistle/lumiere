class YouTube
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def api_url
    "http://gdata.youtube.com/feeds/api/videos/#{@id}?v=2&alt=json"
  end

  def title
    Lumiere.fetch_title(self)
  end

  def description
    Lumiere.fetch_description(self)
  end
end
