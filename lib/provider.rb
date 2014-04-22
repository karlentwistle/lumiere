module Lumiere
  class Provider

    PROVIDERS = %w(YouTubePlaylist YouTube Vimeo)
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

    def api_url
      raise NotImplementedError
    end

    def embed_url
      raise NotImplementedError
    end

    def embed_code
      raise NotImplementedError
    end

    def title
      raise NotImplementedError
    end

    def description
      raise NotImplementedError
    end

    def accessible?
      code = Net::HTTP.get_response(URI(api_url)).code
      @remote_status ||= !%w[403 404].include?(code)
    end

    def ==(other)
      if other.respond_to?(:url)
        url == other.url
      end
    end

    private

    def raw_response
      open(api_url).read
    end
  end
end
