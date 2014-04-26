require 'spec_helper'

module Lumiere
  describe Fetcher do

    describe "#fetch" do
      let(:api_url) { 'http://www.example.com/thing.json' }
      let(:unpack_into) { double(from_json: true) }
      subject(:fetcher) { Fetcher.new(api_url, unpack_into) }

      it "returns the result of from_json on unpack_into" do
        fetcher.stub(:raw_response) { 'raw http data' }
        expect(fetcher.fetch).to eql(true)
      end
    end

  end
end
