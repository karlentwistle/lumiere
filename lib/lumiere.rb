require "lumiere/version"
require 'open-uri'
require 'pry'
require 'json'

module Lumiere

  def self.fetch_title(video)
    remote_structure = remote_structure(video.api_url)
    remote_structure['entry']['title']['$t']
  end

  def self.fetch_description(video)
    remote_structure = remote_structure(video.api_url)
    remote_structure['entry']['media$group']['media$description']['$t']
  end

  private

  def self.remote_structure(api_url)
    raw_response = raw_response(api_url).read
    JSON.parse(raw_response)
  end

  def self.raw_response(url)
    open(url)
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

    def description
      Lumiere.fetch_description(self)
    end
  end

end
