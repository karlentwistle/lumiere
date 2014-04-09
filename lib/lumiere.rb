require "lumiere/version"
require 'open-uri'
require 'pry'
require 'json'
require 'active_support/core_ext/hash'

class Hash
  # Destructively convert all keys to symbols, as long as they respond
  # to +to_sym+.
  # If recursive is set to true, then keys at all levels will be symbolized.
  def symbolize_keys!(recursive = false)
    keys.each do |key|
      value = delete(key)
      key = key.respond_to?(:to_sym) ? key.to_sym : key
      self[key] = (recursive && value.is_a?(Hash)) ? value.dup.symbolize_keys!(recursive) : value
    end
    self
  end
end

module Lumiere

  def self.fetch_title(video)
    remote_structure = remote_structure(video.api_url)
    remote_structure[:entry][:title][:$t]
  end

  def self.fetch_description(video)
    remote_structure = remote_structure(video.api_url)
    remote_structure[:entry][:description][:$t]
  end

  private

  def self.remote_structure(api_url)
    raw_response = raw_response(api_url).read
    JSON.parse(raw_response).symbolize_keys!(true)
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
