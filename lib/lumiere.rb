require "lumiere/version"
require 'open-uri'
require 'net/http'
require 'pry'
require 'json'
Dir[File.dirname(__FILE__) + '/provider/*.rb'].each {|file| require file }

module Lumiere

  def self.fetch(video)
    yield remote_structure(video.api_url)
  end

  private

  def self.remote_structure(api_url)
    raw_response = raw_response(api_url).read
    JSON.parse(raw_response)
  end

  def self.raw_response(url)
    open(url)
  end

end
