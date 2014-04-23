require 'spec_helper'

def valid_urls
  {
    'Xp6CXF' => 'http://www.youtube.com/watch?v=Xp6CXF',
    'BRRolKTlF6Q' => 'https://www.youtube.com/watch?v=BRRolKTlF6Q',
    'elvOZm0d4H0' => 'www.youtube.com/watch?v=elvOZm0d4H0',
    'XTeJ64KD5cg' => 'http://youtube.com/watch?v=XTeJ64KD5cg',
    'iW_LkYiuTKE' => 'https://youtube.com/watch?v=iW_LkYiuTKE',
    'tflf05x-WVI' => 'youtube.com/watch?v=tflf05x-WVI',
    '1GCf29FPM4k' => 'http://youtu.be/1GCf29FPM4k',
    'U7f8j3mVMbc' => 'https://youtu.be/U7f8j3mVMbc',
    'abv4Fz7oNr0' => 'youtu.be/abv4Fz7oNr0',
    'cUCSSJwO3GU' => 'https://www.youtube.com/embed/cUCSSJwO3GU',
    'cUCSSJwO3GA' => 'http://www.youtube.com/embed/cUCSSJwO3GA',
    'cUCSSJwO3GW' => 'www.youtube.com/embed/cUCSSJwO3GW',
    'VeasFckfMHY' => 'http://www.youtube.com/user/EducatorVids3?v=VeasFckfMHY',
    'VeasFckfMHS' => 'http://www.youtube.com/v/VeasFckfMHS',
    'VeasFckfMHA' => 'http://www.youtube.com/v/VeasFckfMHA',
    'BeasFckfMHY' => 'http://www.youtube.com/watch?feature=player_profilepage&v=BeasFckfMHY',
  }
end

module Lumiere
  describe YouTube do
    subject(:video) { YouTube.new('VIDEO_ID') }

    describe ".new_from_video_id" do
      it "returns a new YouTube object with a .useable? url" do
        expect(YouTube.new_from_video_id(1)).to eq(YouTube.new('http://www.youtube.com/watch?v=1'))
      end
    end

    describe ".useable?" do
      context "valid" do
        valid_urls.each_value do |url|
          context "#{url}" do
            it "returns true" do
              expect(YouTube.useable?(url)).to eql(true)
            end
          end
        end
      end
    end

    it "stores url" do
      expect(YouTube.new('http://youtu.be/S_NXz7I5dQc').url).to eql('http://youtu.be/S_NXz7I5dQc')
    end

    describe "video_id" do
      valid_urls.each do |video_id, url|
        context url do
          it "extracts the video_id" do
            expect(YouTube.new(url).video_id).to eql(video_id)
          end
        end
      end
    end

    describe "#api_url" do
      it "returns the url of the YouTube api" do
        video.stub(:video_id) { 'VIDEO_ID' }
        expect(video.api_url).
          to eql('http://gdata.youtube.com/feeds/api/videos/VIDEO_ID?v=2&alt=json')
      end
    end

    describe "#embed_url" do
      it "returns the embed_url" do
        video.stub(:video_id) { 'VIDEO_ID' }
        expect(video.embed_url).to eql('http://www.youtube.com/embed/VIDEO_ID')
      end
    end

    describe "#embed_code" do
      it "returns the embed_code" do
        video.stub(:video_id) { 'VIDEO_ID' }
        expect(video.embed_code).
          to eql('<iframe src="//www.youtube.com/embed/VIDEO_ID" frameborder="0" allowfullscreen></iframe>')
      end
    end

    describe "#title" do
      let(:title) { 'awesome title' }
      let(:remote_structure) {
        {
          'entry' => {
            'title' => {'$t' => title},
          }
        }.to_json
      }
      it "returns the video title" do
        video.stub(:raw_response) { remote_structure }
        expect(video.title).to eql(title)
      end
    end

    describe "#description" do
      let(:description) { 'Description of my awesome Video' }
      let(:remote_structure) {
        {
          'entry' => {
            'media$group' => {
              'media$description' => {
                '$t' => description
              },
            }
          }
        }.to_json
      }
      it "returns the video description" do
        video.stub(:raw_response) { remote_structure }
        expect(video.description).to eql(description)
      end
    end

    describe "#duration" do
      let(:duration) { '35' }
      let(:remote_structure) {
        {
          'entry' => {
            'media$group' => {
              'yt$duration' => {
                'seconds' => duration
              },
            }
          }
        }.to_json
      }
      it "returns the video duration" do
        video.stub(:raw_response) { remote_structure }
        expect(video.duration).to eql(duration.to_i)
      end
    end

    describe "#thumbnail_small" do
      let(:thumbnail_small) { 'Thumbnail Small' }
      let(:remote_structure) {
        {
          'entry' => {
            'media$group' => {
              'media$thumbnail' => [
                {'url' => thumbnail_small},
                {'url' => 'stub'},
                {'url' => 'stub'},
              ],
            }
          }
        }.to_json
      }
      it "returns the video thumbnail_small" do
        video.stub(:raw_response) { remote_structure }
        expect(video.thumbnail_small).to eql(thumbnail_small)
      end
    end

    describe "#thumbnail_medium" do
      let(:thumbnail_medium) { 'Thumbnail Medium' }
      let(:remote_structure) {
        {
          'entry' => {
            'media$group' => {
              'media$thumbnail' => [
                {'url' => 'stub'},
                {'url' => thumbnail_medium},
                {'url' => 'stub'},
              ],
            }
          }
        }.to_json
      }
      it "returns the video thumbnail_medium" do
        video.stub(:raw_response) { remote_structure }
        expect(video.thumbnail_medium).to eql(thumbnail_medium)
      end
    end

    describe "#thumbnail_large" do
      let(:thumbnail_large) { 'Thumbnail Large' }
      let(:remote_structure) {
        {
          'entry' => {
            'media$group' => {
              'media$thumbnail' => [
                {'url' => 'stub'},
                {'url' => 'stub'},
                {'url' => thumbnail_large},
              ],
            }
          }
        }.to_json
      }
      it "returns the video thumbnail_large" do
        video.stub(:raw_response) { remote_structure }
        expect(video.thumbnail_large).to eql(thumbnail_large)
      end
    end
  end

end
