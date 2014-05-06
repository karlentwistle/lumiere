require 'spec_helper'

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
    subject(:playlist) { VimeoPlaylist.new('VIDEO_ID') }

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
        playlist.stub(:playlist_id) { 'PLAYLIST_ID' }
        expect(playlist.api_url).
          to eql('http://vimeo.com/api/v2/album/PLAYLIST_ID/info.json')
      end
    end

    describe "#embed_url" do
      it "returns the embed_url" do
        playlist.stub(:playlist_id) { 'PLAYLIST_ID' }
        expect(playlist.embed_url).to eql('http://player.vimeo.com/hubnut/album/PLAYLIST_ID')
      end
    end

    describe "#embed_code" do
      it "returns the embed_code" do
        playlist.stub(:playlist_id) { 'PLAYLIST_ID' }
        expect(playlist.embed_code).
          to eql('<iframe src="//player.vimeo.com/hubnut/album/PLAYLIST_ID?autoplay=0&byline=0&portrait=0&title=0" frameborder="0"></iframe>')
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
        it "returns the playlist #{attribute}" do
          playlist.stub(:fetch) { double(attribute => expected_value) }
          expect(playlist.send(attribute)).to eql(expected_value)
        end
      end
    end

  end
end
