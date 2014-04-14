require 'spec_helper'

module Lumiere
  describe FetchParse do
    describe "#parse" do
      let(:url) { double }
      let(:parser) { double }
      let(:raw_response) { double(read: true) }

      subject(:remote_response) { FetchParse.new(url, parser) }

      it "calls parse on parser" do
        allow(remote_response).to receive(:open).with(url) { raw_response }
        expect(parser).to receive(:parse).with { raw_response }
        remote_response.parse
      end
    end
  end
end
