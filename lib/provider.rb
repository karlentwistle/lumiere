require 'net/http'

require_relative 'extended_uri'
require_relative 'playlist'
require_relative 'fetcher'
require_relative 'embed_code'

module Lumiere
  class Provider

    PROVIDERS = %w(YouTubePlaylist VimeoPlaylist YouTube Vimeo Dailymotion)
    PROVIDERS.each do |provider|
      require_relative "provider/#{provider.downcase}/#{provider.downcase}"
    end

    def self.delegate(url)
      PROVIDERS.each do |provider|
        provider_class = Object.const_get("Lumiere").const_get(provider)
        if provider_class.useable?(url)
          return provider_class.new(url)
        end
      end

      raise NotImplementedError
    end

    def self.useable?(url)
      delegate(url)
      true
    rescue NotImplementedError
      false
    end

    def video_id
      raise NotImplementedError
    end

    def playlist_id
      raise NotImplementedError
    end

    def api_url
      raise NotImplementedError
    end

    def embed_url
      raise NotImplementedError
    end

    def embed_code
      raise NotImplementedError
    end

    def provider
      raise NotImplementedError
    end

    def title
      raise NotImplementedError
    end

    def description
      raise NotImplementedError
    end

    def duration
      raise NotImplementedError
    end

    def upload_date
      raise NotImplementedError
    end

    def thumbnail_small
      raise NotImplementedError
    end

    def thumbnail_medium
      raise NotImplementedError
    end

    def thumbnail_large
      raise NotImplementedError
    end

    def videos
      raise NotImplementedError
    end

    def accessible?
      response.is_a?(Net::HTTPSuccess)
    end

    def ==(other)
      if other.respond_to?(:video_id)
        video_id == other.video_id
      end
    end

    private

    def response
      uri = URI(api_url)
      Net::HTTP.start(uri.hostname, uri.port, {use_ssl: uri.scheme == 'https'}) {|http|
        http.request_get(uri.request_uri)
      }
    end
  end
end
