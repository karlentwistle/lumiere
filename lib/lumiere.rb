require "lumiere/version"
require 'open-uri'
require 'net/http'
require 'json'

require_relative 'extended_uri'
require_relative 'fetch_parse'
require_relative 'provider'

class Elluminate
  extend Forwardable

  def initialize(url)
    @provider ||= Lumiere::Provider.delegate(url)
  end

  def_delegators :@provider, :title, :description, :duration
  def_delegators :@provider, :thumbnail_small, :thumbnail_medium, :thumbnail_large
  def_delegators :@provider, :embed_code, :embed_url
  def_delegators :@provider, :accessible?
end
