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

    describe "#title" do
      let(:title) { 'awesome playlist title' }
      let(:remote_structure) { { title: title }.to_json }
      it "returns the playlist title" do
        playlist.stub(:raw_response) { remote_structure }
        expect(playlist.title).to eql(title)
      end
    end

    describe "#description" do
      let(:description) { 'awesome playlist description' }
      let(:remote_structure) { { description: description }.to_json }
      it "returns the playlist description" do
        playlist.stub(:raw_response) { remote_structure }
        expect(playlist.description).to eql(description)
      end
    end

    describe "#upload_date" do
      let(:created_on) { Date.today }
      let(:remote_structure) { { created_on: created_on }.to_json }
      it "returns the date the video was uploaded" do
        playlist.stub(:raw_response) { remote_structure }
        expect(playlist.upload_date).to eql(created_on)
      end
    end

    describe "#thumbnail_small" do
      let(:thumbnail_small) { 'http://example.org/small_thumb.jpg' }
      let(:remote_structure) { { thumbnail_small: thumbnail_small }.to_json }
      it "returns the playlist thumbnail_small" do
        playlist.stub(:raw_response) { remote_structure }
        expect(playlist.thumbnail_small).to eql(thumbnail_small)
      end
    end

    describe "#thumbnail_medium" do
      let(:thumbnail_medium) { 'http://example.org/medium_thumb.jpg' }
      let(:remote_structure) { { thumbnail_medium: thumbnail_medium }.to_json }
      it "returns the playlist thumbnail_medium" do
        playlist.stub(:raw_response) { remote_structure }
        expect(playlist.thumbnail_medium).to eql(thumbnail_medium)
      end
    end

    describe "#thumbnail_large" do
      let(:thumbnail_large) { 'http://example.org/large_thumb.jpg' }
      let(:remote_structure) { { thumbnail_large: thumbnail_large }.to_json }
      it "returns the playlist thumbnail_large" do
        playlist.stub(:raw_response) { remote_structure }
        expect(playlist.thumbnail_large).to eql(thumbnail_large)
      end
    end

    describe "#videos" do
      let(:video_1) { { id: 51869492 } }
      let(:video_2) { { id: 50387995 } }
      let(:videos) { [video_1, video_2] }
      let(:remote_structure) { { total_videos: 2 }.to_json }
      let(:remote_structure_video) {
        [
          { 'id' => 51869492 },
          { 'id' => 50387995 }
        ].to_json
      }

      it "returns the videos the playlist contains" do
        playlist.stub(:raw_response_videos) { remote_structure_video }
        playlist.stub(:raw_response) { remote_structure }
        expect(playlist.videos.size).to eql(2)
        expect(playlist.videos).to match_array([
          Vimeo.new_from_video_id(video_1[:id]),
          Vimeo.new_from_video_id(video_2[:id])
        ])
      end
    end

    describe "#total_videos" do
      let(:remote_structure) { { total_videos: 21 }.to_json }
      it "returns the video thumbnail_large" do
        playlist.stub(:raw_response) { remote_structure }
        expect(playlist.total_videos).to eql(21)
      end
    end

  end

end
