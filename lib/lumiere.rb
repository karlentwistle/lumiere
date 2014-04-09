require "lumiere/version"
require 'open-uri'
require 'pry'
require 'json'

module Lumiere

  def self.fetch_title(id)
    JSON.parse(response(id))["entry"]["title"]["$t"]
  end

  private

  def self.response(id)
    method = 'http://'
    base = 'gdata.youtube.com'
    path = "/feeds/api/videos/#{id}?v=2&alt=json"
    url = method << base << path
    open(url).read
  end

  class YouTube
    attr_accessor :id

    def initialize(id)
      @id = id
    end

    def title
      Lumiere.fetch_title(@id)
    end
  end

end
