require "lumiere/version"
require 'open-uri'
require 'net/http'
require 'pry'
require 'json'
require_relative 'provider'
require_relative 'provider/youtube'
require_relative 'provider/vimeo'

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
