module Lumiere
class YouTubePlaylist < Provider
  attr_accessor :url

  USEABLE = ['www.youtube.com', 'youtube.com', 'youtu.be']

  def self.useable?(url)
    uri = URISchemeless.parse(url)
    USEABLE.include?(uri.host) && (uri.path == '/playlist' || uri.path == '/view_play_list')
  end

  def initialize(url, opts={})
    @url = url
    @start_index = opts[:start_index] || 1
    @max_results = opts[:max_results] || 25
  end

  def provider
    "YouTube"
  end

  def playlist_id
    @playlist_id ||= calculate_playlist_id
  end

  def api_url
    url = "http://gdata.youtube.com/feeds/api/playlists/#{playlist_id}"
    url << "?max-results=#{@max_results}"
    url << "&start-index=#{@start_index}"
    url << "&v=2&alt=json"
    url
  end

  def embed_url
    "http://youtube.com/embed/?list=#{playlist_id}"
  end

  def embed_code
    "<iframe src=\"//youtube.com/embed/?list=#{playlist_id}\" frameborder=\"0\" allowfullscreen></iframe>"
  end

  def videos
    fetch! unless defined?(@videos)

    while @start_index < @total_results && @videos.size < @total_results
      @start_index =+ @videos.size + 1
      fetch!
    end

    @all_videos = @videos.map do |video|
      YouTube.new_from_video_id(video.video_id)
    end
  end

  def thumbnail_small
    fetch! unless defined?(@thumbnails)
    @thumbnails[0].url
  end

  def thumbnail_medium
    fetch! unless defined?(@thumbnails)
    @thumbnails[1].url
  end

  def thumbnail_large
    fetch! unless defined?(@thumbnails)
    @thumbnails[2].url
  end

  REMOTE_ATTRIBUTES = [:title, :description, :total_results]

  REMOTE_ATTRIBUTES.each do |attribute|
    define_method(attribute) do
      fetch! unless instance_variable_get("@#{attribute}")
      instance_variable_get("@#{attribute}")
    end
  end

  private

  REMOTE_ATTRIBUTES.each do |attribute|
    attr_writer attribute
  end

  attr_writer :thumbnails

  def videos=(videos)
    @videos ||= []
    @videos += videos
  end

  def fetch!
    self.extend(YouTubePlaylistRepresenter).from_json(raw_response)
  end

  def calculate_playlist_id
    uri = URISchemeless.parse(url)
    params_hash = Hash[URI::decode_www_form(uri.query)]
    params_hash['list'] || params_hash['p']
  end

end
end
