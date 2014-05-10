require_relative '../lib/fetcher'

module Lumiere
  describe Fetcher do
    describe ".remote_attributes" do
      let(:api_url) { 'http://www.example.com/thing.json' }
      let(:unpack_into) { double(from_json: true) }
      subject(:fetcher) { Fetcher.remote_attributes(api_url, unpack_into) }

      it "returns the result of from_json on unpack_into" do
        Fetcher.stub(:scrape).with(api_url) { 'body' }
        expect(fetcher).to eql(true)
      end
    end
  end
end
