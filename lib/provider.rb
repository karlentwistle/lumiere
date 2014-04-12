module Lumiere
  class Provider

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
