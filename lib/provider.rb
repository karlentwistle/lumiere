module Lumiere
  class Provider

    PROVIDERS = %w(YouTubePlaylist VimeoPlaylist YouTube Vimeo)
    PROVIDERS.each do |provider|
      require_relative "provider/#{provider.downcase}/#{provider.downcase}"
      require_relative "provider/#{provider.downcase}/representer"
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
      code = Net::HTTP.get_response(URI(api_url)).code
      @remote_status ||= !%w[403 404].include?(code)
    end

    def ==(other)
      if other.respond_to?(:video_id)
        video_id == other.video_id
      end
    end
  end
end
