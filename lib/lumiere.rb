require "lumiere/version"
require 'forwardable'

require_relative 'provider'

class Elluminate
  extend Forwardable

  def initialize(url)
    @provider ||= Lumiere::Provider.delegate(url)
  end

  def self.useable?(url)
    Lumiere::Provider.useable?(url)
  end

  def_delegators :@provider, :video_id, :playlist_id
  def_delegators :@provider, :provider, :upload_date
  def_delegators :@provider, :title, :description, :duration
  def_delegators :@provider, :thumbnail_small, :thumbnail_medium, :thumbnail_large
  def_delegators :@provider, :embed_code, :embed_url
  def_delegators :@provider, :accessible?
  def_delegators :@provider, :videos
end
