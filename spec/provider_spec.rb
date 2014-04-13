require 'spec_helper'

module Lumiere
  describe Provider do
    subject(:provider) { Provider.new }

    describe ".delegate" do
      context "YouTube URL" do
        let(:url) { 'www.youtube.com' }
        let(:youtube) { double }
        it "sets 'delegate' instance variable with new YouTube" do
          expect(YouTube).to receive(:useable?).with(url) { true }
          expect(YouTube).to receive(:new).with(url) { youtube }
          expect(Provider.delegate(url)).to eql(youtube)
        end
      end

      context "Vimeo URL" do
        let(:url) { 'www.vimeo.com' }
        let(:vimeo) { double }
        it "sets 'delegate' instance variable with new Vimeo" do
          allow(YouTube).to receive(:useable?).with(url) { false }
          expect(Vimeo).to receive(:useable?).with(url) { true }
          expect(Vimeo).to receive(:new).with(url) { vimeo }
          expect(Provider.delegate(url)).to eql(vimeo)
        end
      end

      context "Unsupported URL" do
        let(:url) { 'unsupported' }
        it "raises an exception" do
          expect {
            Provider.delegate(url)
          }.to raise_exception("sorry Lumiere doesnt currently support that provider")
        end
      end
    end

    describe "#accessible?" do
      let(:api_url) { 'http://www.example.com/VIDEO-ID/remote_structure.json' }
      before do
        provider.stub(api_url: api_url)
      end
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