class Vimeo
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def api_url
    "http://vimeo.com/api/v2/video/#{id}.json"
  end

  %w(title description duration).each do |meth|
    define_method(meth) do
      Lumiere.fetch(self){ |rs| rs[0][meth] }
    end
  end
end
