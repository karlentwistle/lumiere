class YouTube
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def api_url
    "http://gdata.youtube.com/feeds/api/videos/#{@id}?v=2&alt=json"
  end

  REMOTE_MAP = {
    title: lambda { |rs| rs['entry']['title']['$t'] },
    description: lambda { |rs| rs['entry']['media$group']['media$description']['$t'] },
    duration: lambda { |rs| rs["entry"]["media$group"]["yt$duration"]["seconds"].to_i },
  }

  REMOTE_MAP.each do |meth_name, remote_location|
    define_method(meth_name) do
      Lumiere.fetch(self) { |rs| remote_location.call(rs) }
    end
  end

  def accessible?
    code = Net::HTTP.get_response(URI(api_url)).code
    !%w[403 404].include?(code)
  end
end
