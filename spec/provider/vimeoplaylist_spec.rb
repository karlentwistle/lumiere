require_relative '../../lib/provider/vimeoplaylist/vimeoplaylist'

def valid_urls
  {
    '12355718' => 'www.vimeo.com/album/12355718',
    '2755718' => '//vimeo.com/album/2755718',
    '27221718' => 'http://vimeo.com/album/27221718',
    '37221718' => 'https://vimeo.com/album/37221718',
    '2123118' => 'http://player.vimeo.com/hubnut/album/2123118',
    '98989' =>'https://player.vimeo.com/hubnut/album/98989',
    '20020' =>'//player.vimeo.com/hubnut/album/20020',
  }
end

def invalid_urls
  [
    'https://www.vimeo.com/89682547',
    'www.vimeo.com/8968222',
    'http://vimeo.com/10000',
    'https://vimeo.com/99999',
    'vimeo.com/80',
    '//player.vimeo.com/video/92224516?badge=0',
    'http://player.vimeo.com/video/15468',
    'player.vimeo.com/video/10',
    'http://player.vimeo.com/video/999',
    'http://player.vimeo.com/video/1010'
  ]
end

module Lumiere
  describe Vimeo do
    subject(:playlist) { VimeoPlaylist.new('//player.vimeo.com/hubnut/album/92224516') }

    describe ".useable?" do
      context "valid" do
        valid_urls.each_value do |url|
          context "#{url}" do
            it "returns true" do
              expect(VimeoPlaylist.useable?(url)).to eql(true)
            end
          end
        end
      end

      context "invalid" do
        invalid_urls.each do |url|
          context "#{url}" do
            it "returns false" do
              expect(VimeoPlaylist.useable?(url)).to eql(false)
            end
          end
        end
      end
    end

    it "stores url" do
      expect(VimeoPlaylist.new('www.vimeo.com/4268592').url).to eql('www.vimeo.com/4268592')
    end

    describe "playlist_id" do
      valid_urls.each do |playlist_id, url|
        context url do
          it "extracts the playlist_id" do
            expect(VimeoPlaylist.new(url).playlist_id).to eql(playlist_id)
          end
        end
      end
    end

    describe "#provider" do
      it "returns Vimeo" do
        expect(playlist.provider).to eql("Vimeo")
      end
    end

    describe "#api_url" do
      it "returns the url of the Vimeo api" do
        expect(playlist.api_url).
          to eql('http://vimeo.com/api/v2/album/92224516/info.json')
      end
    end

    describe "#embed_url" do
      it "returns the embed_url" do
        expect(playlist.embed_url).to eql('//player.vimeo.com/hubnut/album/92224516')
      end
    end

    describe "#embed_code" do
      context "no options" do
        it "returns the embed_code with the default options" do
          expect(playlist.embed_code).
            to eql('<iframe src="//player.vimeo.com/hubnut/album/92224516?autoplay=0&byline=0&portrait=0&title=0" frameborder="0"></iframe>')
        end
      end

      context "options" do
        it "returns the embed_code with options appended to defaults" do
          expect(playlist.embed_code(iframe_attributes: {width: 800, height: 600})).
            to eql('<iframe src="//player.vimeo.com/hubnut/album/92224516?autoplay=0&byline=0&portrait=0&title=0" frameborder="0" width="800" height="600"></iframe>')
        end
      end
    end

    remotes = {
      title: 'awesome title',
      description: 'awesome description',
      upload_date: Date.today,
      thumbnail_small: 'http://example.org/small_thumb.jpg',
      thumbnail_medium: 'http://example.org/medium_thumb.jpg',
      thumbnail_large: 'http://example.org/large_thumb.jpg',
      total_videos: 21,
    }.each do |attribute, expected_value|
      describe "##{attribute}" do
        let(:remote_attributes) { double(attribute => expected_value) }
        it "returns the playlist #{attribute}" do
          allow(Fetcher).to receive(:remote_attributes) { remote_attributes }
          expect(playlist.send(attribute)).to eql(expected_value)
        end

        it "memomized the call to fetcher" do
          expect(Fetcher).to receive(:remote_attributes).once { remote_attributes }
          2.times do
            playlist.send(attribute)
          end
        end
      end
    end

  end
end
