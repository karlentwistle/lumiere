require_relative 'representer'
require_relative '../../provider'

module Lumiere
class YouTubePlaylist < Provider
  attr_accessor :url
  include EmbedCode

  USEABLE = ['www.youtube.com', 'youtube.com', 'youtu.be']
  RESULTS_PER_REQUEST = 25

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
    url << "?max-results=#{RESULTS_PER_REQUEST}"
    url << "&start-index=#{@start_index}"
    url << "&v=2&alt=json"
    url
  end

  def embed_url
    "//youtube.com/embed/?list=#{playlist_id}"
  end

  def default_attributes
    {
      iframe_attributes: {
        frameborder: 0,
        allowfullscreen: true
      }
    }
  end

  def videos
    if @videos && @videos.size == total_results
      return @videos
    end

    @videos = fetch.videos
    #take into account the first request that calling total_results will trigger through fetch!
    #todo refactor this
    remaining_pages = page_count - 1
    remaining_pages.times do
      @start_index =+ @videos.size + 1
      @videos += fetch!.videos
    end

    @videos.map do |video|
      YouTube.new_from_video_id(video.video_id, video)
    end
  end

  def page_count
    Playlist.page_count(total_results, RESULTS_PER_REQUEST)
  end

  def thumbnail_small
    fetch.thumbnails[0].url
  end

  def thumbnail_medium
    fetch.thumbnails[1].url
  end

  def thumbnail_large
    fetch.thumbnails[2].url
  end

  def title
    fetch.title
  end

  def description
    fetch.description
  end

  def total_results
    fetch.total_results
  end

  def unpack_into
    struct = OpenStruct.new
    struct.extend(YouTubePlaylistRepresenter)
  end

  private

  def fetch
    @fetch ||= fetch!
  end

  def fetch!
    Fetcher.remote_attributes(api_url, unpack_into)
  end

  def calculate_playlist_id
    uri = URISchemeless.parse(url)
    params_hash = Hash[URI::decode_www_form(uri.query)]
    params_hash['list'] || params_hash['p']
  end

end
end
