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
  }
end

module Lumiere
  describe YouTubePlaylist do
    let(:description) { 'Description of my awesome playlist' }
    let(:title) { 'Title of my awesome playlist' }
    let(:thumbnail_small) { 'Thumbnail Small' }
    let(:thumbnail_medium) { 'Thumbnail Medium' }
    let(:thumbnail_large) { 'Thumbnail Large' }
    let(:videos) {
      [
        { id: '2_HXUhShhmY' },
        { id: 'vLrslkB1pG8' },
      ]
    }
    #let(:duration) { 35 }
    let(:remote_structure) {
      {
        'feed' => {
          'title' => {'$t' => title},
          'subtitle' => {'$t' => description},
          'media$group' => {
            'media$thumbnail' => [
              {'url' => thumbnail_small},
              {'url' => thumbnail_medium},
              {'url' => thumbnail_large},
            ]
          },
          'entry' => [
            {
              'media$group' => {
                'yt$videoid' => {
                  '$t' => videos[0][:id]
                }
              }
            },
            {
              'media$group' => {
                'yt$videoid' => {
                  '$t' => videos[1][:id]
                }
              }
            },
          ]
        }
      }
    }

    subject(:playlist) { YouTubePlaylist.new('VIDEO_ID') }

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

    describe "#api_url" do
      it "returns the url of the Vimeo api" do
        playlist.stub(:playlist_id) { 'PLAYLIST_ID' }
        expect(playlist.api_url).
          to eql('http://gdata.youtube.com/feeds/api/playlists/PLAYLIST_ID?v=2&alt=json')
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

    describe "#title" do
      it "returns the video title" do
        playlist.stub(:fetch) { remote_structure }
        expect(playlist.title).to eql(title)
      end
    end

    describe "#videos" do
      it "returns the videos the playlist contains" do
        playlist.stub(:fetch) { remote_structure }
        expect(playlist.videos).to match_array([
          YouTube.new_from_video_id(videos[0][:id]),
          YouTube.new_from_video_id(videos[1][:id])
        ])
      end
    end

    describe "#description" do
      it "returns the video description" do
        playlist.stub(:fetch) { remote_structure }
        expect(playlist.description).to eql(description)
      end
    end

    # describe "#duration" do
    #   it "returns the video duration" do
    #     video.stub(:fetch) { remote_structure }
    #     expect(video.duration).to eql(duration)
    #   end
    # end

    describe "#thumbnail_small" do
      it "returns the video thumbnail_small" do
        playlist.stub(:fetch) { remote_structure }
        expect(playlist.thumbnail_small).to eql(thumbnail_small)
      end
    end

    describe "#thumbnail_medium" do
      it "returns the video thumbnail_medium" do
        playlist.stub(:fetch) { remote_structure }
        expect(playlist.thumbnail_medium).to eql(thumbnail_medium)
      end
    end

    describe "#thumbnail_large" do
      it "returns the video thumbnail_large" do
        playlist.stub(:fetch) { remote_structure }
        expect(playlist.thumbnail_large).to eql(thumbnail_large)
      end
    end
  end

end