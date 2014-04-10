require "lumiere/version"
require 'open-uri'
require 'pry'
require 'json'
Dir[File.dirname(__FILE__) + '/provider/*.rb'].each {|file| require file }

module Lumiere

  def self.fetch_title(video)
    remote_structure = remote_structure(video.api_url)
    if video.class == Vimeo
      remote_structure['title']
    else
      remote_structure['entry']['title']['$t']
    end
  end

  def self.fetch_description(video)
    remote_structure = remote_structure(video.api_url)
    if video.class == Vimeo
      remote_structure['description']
    else
      remote_structure['entry']['media$group']['media$description']['$t']
    end
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
