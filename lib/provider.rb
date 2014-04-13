module Lumiere
  class Provider

    PROVIDERS = %w(YouTube Vimeo)
    PROVIDERS.each do |provider|
      require_relative "provider/#{provider.downcase}"
    end

    def self.delegate(url)
      PROVIDERS.each do |provider|
        provider_class = Object.const_get("Lumiere").const_get(provider)
        if provider_class.useable?(url)
          return provider_class.new(url)
        end
      end

      raise "sorry Lumiere doesnt currently support that provider"
    end

    def api_url
      raise "provider must provide a api_url"
    end

    def embed_url
      raise "provider must provide a embed_url"
    end

    def embed_code
      raise "provider must provide a embed_code"
    end

    def title
      raise "provider must provide a title"
    end

    def description
      raise "provider must provide a description"
    end

    def accessible?
      code = Net::HTTP.get_response(URI(api_url)).code
      @remote_status ||= !%w[403 404].include?(code)
    end

  end
end
