module Lumiere
class VimeoPlaylist < Provider
  attr_accessor :url

  USEABLE = ['vimeo.com', 'player.vimeo.com', 'www.vimeo.com']
  MAX_RESULTS = 20

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
    fetch! unless @title
    @title
  end

  def description
    fetch! unless @description
    @description
  end

  def upload_date
    fetch! unless @upload_date
    @upload_date
  end

  def thumbnail_small
    fetch! unless @thumbnail_small
    @thumbnail_small
  end

  def thumbnail_medium
    fetch! unless @thumbnail_medium
    @thumbnail_medium
  end

  def thumbnail_large
    fetch! unless @thumbnail_large
    @thumbnail_large
  end

  def total_videos
    fetch! unless @total_videos
    @total_videos
  end

  def videos
    return @videos if @videos

    videos = page_count.times.with_index(1).flat_map do |_, index|
      fetch_videos(index)
    end

    @videos = videos.map do |video| #TODO: Make fetch_videos return Vimeo objects and remove this line
      Vimeo.new_from_video_id(video.id)
    end
  end

  private

  attr_writer :title, :description, :upload_date, :thumbnail_small, :thumbnail_medium, :thumbnail_large, :total_videos

  def page_count
    page_count = Playlist.page_count(total_videos, MAX_RESULTS)
    #VIMEO CANT DEAL WITH MORE THAN 60 RESULTS ON SIMPLE API...
    page_count = 3 if page_count > 3
    page_count
  end

  def fetch!
    self.extend(VimeoPlaylistRepresenter).from_json(raw_response)
  end

  def fetch_videos(page=1)
    [].extend(VimeoVideosRepresenter).from_json(raw_response_videos(page))
  end

  def raw_response_videos(page=1)
    url = "http://vimeo.com/api/v2/album/#{playlist_id}/videos.json?page=#{page}"
    open(url).read
  end

  def calculate_playlist_id
    uri = URISchemeless.parse(url)
    uri.path.gsub!('/hubnut/album/', '')
    uri.path.gsub!('/album/', '')
    uri.path.delete!('/')
    uri.path
  end

end
end
