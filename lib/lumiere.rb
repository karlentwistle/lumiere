require "lumiere/version"
require 'open-uri'
require 'net/http'
require 'json'

require_relative 'remote_response'
require_relative 'provider'
Lumiere::Provider::PROVIDERS.each do |provider|
  require_relative "provider/#{provider.downcase}"
end

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
