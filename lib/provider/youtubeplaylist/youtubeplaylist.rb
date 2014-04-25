module Lumiere
class YouTubePlaylist < Provider
  attr_accessor :url

  USEABLE = ['www.youtube.com', 'youtube.com', 'youtu.be']
  MAX_RESULTS = 25

  def self.useable?(url)
    uri = URISchemeless.parse(url)
    USEABLE.include?(uri.host) && (uri.path == '/playlist' || uri.path == '/view_play_list')
  end

  def initialize(url, opts={})
    @url = url
    @start_index = opts[:start_index] || 1
  end

  def provider
    "YouTube"
  end

  def playlist_id
    @playlist_id ||= calculate_playlist_id
  end

  def api_url
    url = "http://gdata.youtube.com/feeds/api/playlists/#{playlist_id}"
    url << "?max-results=#{MAX_RESULTS}"
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
    if @videos && @videos.size == total_results
      return @videos
    end

    #take into account the first request that calling total_results will trigger through fetch!
    #todo refactor this
    remaining_pages = page_count - 1

    remaining_pages.times do
      @start_index =+ @videos.size + 1
      fetch!
    end

    @videos
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

  def title
    fetch! unless defined?(@title)
    @title
  end

  def description
    fetch! unless defined?(@description)
    @description
  end

  def total_results
    fetch! unless defined?(@total_results)
    @total_results
  end

  private

  attr_writer :thumbnails, :title, :description, :total_results

  def page_count
    Playlist.page_count(total_results, MAX_RESULTS)
  end

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
