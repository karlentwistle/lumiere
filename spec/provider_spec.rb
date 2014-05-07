require 'spec_helper'
require_relative '../lib/provider'

module Lumiere
  describe Provider do
    subject(:provider) { Provider.new }

    describe ".delegate" do
      context "Single Provider" do
        let(:url) { 'www.youtube.com' }
        let(:youtube) { double }
        it "sets 'delegate' instance variable with new YouTube" do
          expect(YouTube).to receive(:useable?).with(url) { true }
          expect(YouTube).to receive(:new).with(url) { youtube }
          expect(Provider.delegate(url)).to eql(youtube)
        end
      end

      context "Multiple Providers" do
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
          }.to raise_exception(NotImplementedError)
        end
      end
    end

    describe ".useable?" do
      context "Single Provider" do
        let(:url) { 'http://youtube.com/watch?v=XTeJ64KD5cg' }
        it "returns true" do
          expect(Provider.useable?(url)).to be_true
        end
      end

      context "Multiple Providers" do
        let(:url) { 'https://www.vimeo.com/89682547' }
        it "returns true" do
          expect(Provider.useable?(url)).to be_true
        end
      end

      context "Unsupported URL" do
        let(:url) { 'http://video.google.com/videoplay?docid=5547481422995115331&hl=en' }
        it "returns false" do
          expect(Provider.useable?(url)).to be_false
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
