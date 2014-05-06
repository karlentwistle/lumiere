module Lumiere
class VimeoPlaylist < Provider
  attr_accessor :url

  USEABLE = ['vimeo.com', 'player.vimeo.com', 'www.vimeo.com']
  RESULTS_PER_REQUEST = 20

  def self.useable?(url)
    uri = URISchemeless.parse(url)
    return false unless USEABLE.include?(uri.host)
    split_path = uri.path.split('/')
    split_path.include?('album')
  end

  def initialize(url)
    @url = url
  end

  def provider
    "Vimeo"
  end

  def playlist_id
    @playlist_id ||= calculate_playlist_id
  end

  def api_url
    "http://vimeo.com/api/v2/album/#{playlist_id}/info.json"
  end

  def embed_url
    "http://player.vimeo.com/hubnut/album/#{playlist_id}"
  end

  def embed_code
    "<iframe src=\"//player.vimeo.com/hubnut/album/#{playlist_id}?autoplay=0&byline=0&portrait=0&title=0\" frameborder=\"0\"></iframe>"
  end

  def title
    fetch.title
  end

  def description
    fetch.description
  end

  def upload_date
    fetch.upload_date
  end

  def thumbnail_small
    fetch.thumbnail_small
  end

  def thumbnail_medium
    fetch.thumbnail_medium
  end

  def thumbnail_large
    fetch.thumbnail_large
  end

  def total_videos
    fetch.total_videos
  end

  def unpack_into
    struct = OpenStruct.new
    struct.extend(VimeoPlaylistRepresenter)
  end

  def videos
    @videos ||= VideoFetcher.new(playlist_id, total_videos).videos
  end

  private

  def fetch
    @fetch ||= Fetcher.new(self).remote_attributes
  end

  def calculate_playlist_id
    uri = URISchemeless.parse(url)
    uri.path.gsub!('/hubnut/album/', '')
    uri.path.gsub!('/album/', '')
    uri.path.delete!('/')
    uri.path
  end

  class VideoFetcher
    RESULTS_PER_REQUEST = 20

    def initialize(playlist_id, total_videos)
      @playlist_id = playlist_id
      @total_videos = total_videos
      @page = 1
    end

    def videos
      videos = []
      page_count.times do
        videos += fetched_videos
        @page += 1
      end

      videos.map do |video|
        Vimeo.new_from_video_id(video.video_id, video)
      end
    end

    def api_url
      "http://vimeo.com/api/v2/album/#{@playlist_id}/videos.json?page=#{@page}"
    end

    def unpack_into
      struct = []
      struct.extend(VimeoVideosRepresenter)
    end

    private

    def fetched_videos
      fetch
    end

    def fetch
      Fetcher.new(self).remote_attributes
    end

    def page_count
      page_count = Playlist.page_count(@total_videos, RESULTS_PER_REQUEST)
      #VIMEO CANT DEAL WITH MORE THAN 60 RESULTS ON SIMPLE API...
      page_count = 3 if page_count > 3
      page_count
    end
  end

end
end
