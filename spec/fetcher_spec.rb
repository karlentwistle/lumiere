require 'spec_helper'

module Lumiere
  describe Fetcher do

    describe "#remote_attributes" do
      let(:api_url) { 'http://www.example.com/thing.json' }
      let(:unpack_into) { double(from_json: true) }
      let(:context) { double(api_url: api_url, unpack_into: unpack_into) }
      subject(:fetcher) { Fetcher.new(context) }

      it "returns the result of from_json on unpack_into" do
        fetcher.stub(:raw_response) { double }
        expect(fetcher.remote_attributes).to eql(true)
      end

      it "memomized unpack_into objects based on their api_url" do
        expect(fetcher).to receive(:raw_response).once { double }
        fetcher.remote_attributes
        fetcher.remote_attributes
      end
    end

  end
end
