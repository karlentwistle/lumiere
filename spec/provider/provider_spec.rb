require 'spec_helper'

module Lumiere
  describe Provider do

    let(:api_url) { 'http://www.example.com/VIDEO-ID/remote_structure.json' }
    subject(:provider) { Provider.new }

    before do
      provider.stub(api_url: api_url)
    end

    describe "#accessible?" do
      context "private video" do
        it "returns false" do
          stub_request(:any, api_url).to_return(status: 403)
          VCR.turned_off do
            expect(provider.accessible?).to be_false
          end
        end
      end

      context "dmca video" do
        it "returns false" do
          stub_request(:any, api_url).to_return(status: 403)
          VCR.turned_off do
            expect(provider.accessible?).to be_false
          end
        end
      end

      context "removed video" do
        it "returns false" do
          stub_request(:any, api_url).to_return(status: 404)
          VCR.turned_off do
            expect(provider.accessible?).to be_false
          end
        end
      end

      context "public video" do
        it "returns true" do
          stub_request(:any, api_url).to_return(status: 200)
          VCR.turned_off do
            expect(provider.accessible?).to be_true
          end
        end
      end
    end
  end
end
