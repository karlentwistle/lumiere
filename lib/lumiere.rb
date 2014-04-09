require "lumiere/version"
require 'open-uri'
require 'pry'
require 'json'

module Lumiere

  def self.fetch_title(video)
    structure = response(video.api_url)
    structure[:entry][:title]["$t"]
  end

  private

  def self.response(api_url)
    raw_response = open(api_url).read
    JSON.parse(raw_response)
  end

  class YouTube
    attr_accessor :id

    def initialize(id)
      @id = id
    end

    def api_url
      "http://gdata.youtube.com/feeds/api/videos/#{@id}?v=2&alt=json"
    end

    def title
      Lumiere.fetch_title(self)
    end
  end

end
