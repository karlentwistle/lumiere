module Lumiere
  class Provider

    PROVIDERS = %w(YouTube Vimeo)

    def self.delegate(url)
      PROVIDERS.each do |provider|
        provider_class = Object.const_get(provider)
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

    def fetch
      remote_structure(api_url)
    end

    def accessible?
      code = Net::HTTP.get_response(URI(api_url)).code
      @remote_status ||= !%w[403 404].include?(code)
    end

    private

    def remote_structure(api_url)
      raw_response = raw_response(api_url).read
      @remote_structure ||= JSON.parse(raw_response)
    end

    def raw_response(url)
      open(url)
    end

  end
end
