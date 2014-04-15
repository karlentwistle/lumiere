module Lumiere
class YouTubePlaylist < Provider
  include ExtendedURI
  attr_accessor :url

  USEABLE = ['www.youtube.com', 'youtube.com', 'youtu.be']

  def self.useable?(url)
    uri = schemeless_parse(url)
    USEABLE.include?(uri.host.to_s) && (uri.path == '/playlist' || uri.path == '/view_play_list')
  end

  def initialize(url)
    @url = url
  end

  def playlist_id
    @playlist_id ||= calculate_playlist_id
  end

  def api_url
    "http://gdata.youtube.com/feeds/api/playlists/#{playlist_id}?v=2&alt=json"
  end

  def embed_url
    "http://youtube.com/embed/?list=#{playlist_id}"
  end

  def embed_code
    "<iframe src=\"//youtube.com/embed/?list=#{playlist_id}\" frameborder=\"0\" allowfullscreen></iframe>"
  end

  def videos
    fetch['feed']['entry'].map do |entry|
      YouTube.new_from_video_id(entry['media$group']['yt$videoid']['$t'])
    end
  end

  def title
    fetch['feed']['title']['$t']
  end

  def description
    fetch['feed']['subtitle']['$t']
  end

  def thumbnail_small
    fetch['feed']['media$group']['media$thumbnail'][0]['url']
  end

  def thumbnail_medium
    fetch['feed']['media$group']['media$thumbnail'][1]['url']
  end

  def thumbnail_large
    fetch['feed']['media$group']['media$thumbnail'][2]['url']
  end

  private

  def fetch
    @remote_structure ||= Lumiere::FetchParse.new(api_url, JSON).parse
  end

  def calculate_playlist_id
    uri = schemeless_parse(url)
    params_hash = Hash[URI::decode_www_form(uri.query)]
    params_hash['list'] || params_hash['p']
  end

end
end



