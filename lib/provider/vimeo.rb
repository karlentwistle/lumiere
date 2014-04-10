class Vimeo
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def api_url
    "http://vimeo.com/api/v2/video/#{id}.json"
  end

  def title
    Lumiere.fetch_title(self)
  end

  def description
    Lumiere.fetch_description(self)
  end
end
