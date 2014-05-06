require 'spec_helper'

def valid_urls
  {
    'PL48A83AD3506C9D35' => 'youtube.com/playlist?list=PL48A83AD3506C9D35',
    'ASD8A83AD3506C9D123' => 'http://youtube.com/playlist?list=ASD8A83AD3506C9D123',
    'PL48A83AD3506C9D36' => 'www.youtube.com/playlist?list=PL48A83AD3506C9D36',
    'PL48A83AD3506C9D37' => 'http://www.youtube.com/playlist?list=PL48A83AD3506C9D37',
    'PL48A83AD3506C9D38' => 'https://www.youtube.com/playlist?list=PL48A83AD3506C9D38',
    '63F0C78739B09958' => 'https://www.youtube.com/view_play_list?p=63F0C78739B09958',
    '63F0C7873' => 'youtube.com/view_play_list?p=63F0C7873',
    'PLGznEl712WekhqwD9jh3YXR-cJTjSBVjQ' => 'https://www.youtube.com/playlist?p=PLGznEl712WekhqwD9jh3YXR-cJTjSBVjQ',
    'AGGznEl712WekhqwD9jh3YXR-cJTjSBVjQ' => 'https://youtube.com/playlist?p=AGGznEl712WekhqwD9jh3YXR-cJTjSBVjQ',
    'WAD-cJTjSBVjQ' => 'http://www.youtube.com/playlist?p=WAD-cJTjSBVjQ',
  }
end

module Lumiere
  describe YouTubePlaylist do
    subject(:playlist) { YouTubePlaylist.new('http://www.youtube.com/playlist?list=VIDEO_ID') }

    describe ".useable?" do
      context "valid" do
        valid_urls.each_value do |url|
          context "#{url}" do
            it "returns true" do
              expect(YouTubePlaylist.useable?(url)).to eql(true)
            end
          end
        end
      end
    end

    let(:url) { 'https://www.youtube.com/playlist?list=PL48A83AD3506C9D36' }
    it "stores url" do
      expect(YouTubePlaylist.new(url).url).to eql(url)
    end

    describe "playlist_id" do
      valid_urls.each do |playlist_id, url|
        context url do
          it "extracts the playlist_id" do
            expect(YouTubePlaylist.new(url).playlist_id).to eql(playlist_id)
          end
        end
      end
    end

    describe "#provider" do
      it "returns YouTube" do
        expect(playlist.provider).to eql("YouTube")
      end
    end

    describe "#api_url" do
      context "no opts passed" do
        it "returns the url of the YouTube api" do
          expect(playlist.api_url).
            to eql('http://gdata.youtube.com/feeds/api/playlists/VIDEO_ID?max-results=25&start-index=1&v=2&alt=json')
        end
      end

      context "start_index" do
        subject(:playlist) { YouTubePlaylist.new('http://www.youtube.com/playlist?list=VIDEO_ID', start_index: 26) }
        it "returns the url of the YouTube api with start_index" do
          expect(playlist.api_url).
            to eql('http://gdata.youtube.com/feeds/api/playlists/VIDEO_ID?max-results=25&start-index=26&v=2&alt=json')
        end
      end

    end

    describe "#embed_url" do
      it "returns the embed_url" do
        playlist.stub(:playlist_id) { 'PLAYLIST_ID' }
        expect(playlist.embed_url).to eql('http://youtube.com/embed/?list=PLAYLIST_ID')
      end
    end

    describe "#embed_code" do
      it "returns the embed_code" do
        playlist.stub(:playlist_id) { 'PLAYLIST_ID' }
        expect(playlist.embed_code).to eql('<iframe src="//youtube.com/embed/?list=PLAYLIST_ID" frameborder="0" allowfullscreen></iframe>')
      end
    end

    remotes = {
      title: 'Title of my awesome playlist',
      description: 'Description of my awesome playlist',
      total_results: 12,
    }.each do |attribute, expected_value|
      describe "##{attribute}" do
        it "returns the playlist #{attribute}" do
          playlist.stub(:fetch) { double(attribute => expected_value) }
          expect(playlist.send(attribute)).to eql(expected_value)
        end
      end
    end

    describe "#thumbnail_small" do
      let(:thumbnail_small) { 'http://example.org/small_thumb.jpg' }
      it "returns the playlist thumbnail_small" do
        playlist.stub(:fetch) {
          double(thumbnails:[double(url: thumbnail_small)])
        }
        expect(playlist.thumbnail_small).to eql(thumbnail_small)
      end
    end

    describe "#thumbnail_medium" do
      let(:thumbnail_medium) { 'http://example.org/medium_thumb.jpg' }
      it "returns the playlist thumbnail_medium" do
        playlist.stub(:fetch) {
          double(thumbnails:[nil, double(url: thumbnail_medium)])
        }
        expect(playlist.thumbnail_medium).to eql(thumbnail_medium)
      end
    end

    describe "#thumbnail_large" do
      let(:thumbnail_large) { 'http://example.org/large_thumb.jpg' }
      it "returns the playlist thumbnail_large" do
        playlist.stub(:fetch) {
          double(thumbnails:[nil, nil, double(url: thumbnail_large)])
        }
        expect(playlist.thumbnail_large).to eql(thumbnail_large)
      end
    end

  end

end
