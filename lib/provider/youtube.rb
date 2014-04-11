class YouTube
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def api_url
    "http://gdata.youtube.com/feeds/api/videos/#{@id}?v=2&alt=json"
  end

  def title
    Lumiere.fetch(self) { |rs| rs['entry']['title']['$t'] }
  end

  def description
    Lumiere.fetch(self) { |rs| rs['entry']['media$group']['media$description']['$t'] }
  end

  def duration
    Lumiere.fetch(self) { |rs| rs["entry"]["media$group"]["yt$duration"]["seconds"].to_i }
  end

end
