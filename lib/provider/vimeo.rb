class Vimeo < Lumiere::Provider
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def api_url
    "http://vimeo.com/api/v2/video/#{id}.json"
  end

  REMOTE_MAP = {
    title: lambda { |rs| rs[0]['title'] },
    description: lambda { |rs| rs[0]['description'] },
    duration: lambda { |rs| rs[0]['duration'].to_i },
    thumbnail_small: lambda { |rs| rs[0]['thumbnail_small'] },
    thumbnail_medium: lambda { |rs| rs[0]['thumbnail_medium'] },
    thumbnail_large: lambda { |rs| rs[0]['thumbnail_large'] },
  }

  REMOTE_MAP.each do |meth_name, remote_location|
    define_method(meth_name) do
      fetch { |rs| remote_location.call(rs) }
    end
  end
end
