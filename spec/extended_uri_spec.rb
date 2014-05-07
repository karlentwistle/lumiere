require_relative '../lib/extended_uri'

module Lumiere
  describe URISchemeless do
    describe ".schemeless_parse" do
      subject(:schemeless_parse) { URISchemeless.parse(url) }

      context 'url contains http' do
        let(:url) { 'http://example.com/' }
        it "returns a uri parse object with url unmodified" do
          expect(schemeless_parse).to be_a(URI)
          expect(schemeless_parse.host).to eql('example.com')
          expect(schemeless_parse.to_s).to eql('http://example.com/')
        end
      end

      context 'url contains https' do
        let(:url) { 'https://example.com/' }
        it "returns a uri parse object with url unmodified" do
          expect(schemeless_parse).to be_a(URI)
          expect(schemeless_parse.host).to eql('example.com')
          expect(schemeless_parse.to_s).to eql('https://example.com/')
        end
      end

      context 'url contains schema relative to the current scheme' do
        let(:url) { '//example.com/' }
        it "returns a uri parse object with url unmodified" do
          expect(schemeless_parse).to be_a(URI)
          expect(schemeless_parse.host).to eql('example.com')
          expect(schemeless_parse.to_s).to eql('http://example.com/')
        end
      end

      context 'url contains no scheme' do
        let(:url) { 'example.com/thing' }
        it "returns a uri parse object with url modified to include http" do
          expect(schemeless_parse).to be_a(URI)
          expect(schemeless_parse.host).to eql('example.com')
          expect(schemeless_parse.to_s).to eql('http://example.com/thing')
        end
      end

    end
  end
end
