class Vimeo
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def api_url
    "http://vimeo.com/api/v2/video/#{id}.json"
  end

  def title
    Lumiere.fetch(self) { |rs| rs['title'] }
  end

  def description
    Lumiere.fetch(self) { |rs| rs['description'] }
  end
end
