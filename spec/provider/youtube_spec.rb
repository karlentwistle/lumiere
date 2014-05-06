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

    describe "#provider" do
      it "returns YouTube" do
        expect(video.provider).to eql("YouTube")
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

    remotes = {
      title: 'awesome title',
      description: 'Description of my awesome Video',
      upload_date: Date.today,
      duration: '35',
    }.each do |attribute, expected_value|
      describe "##{attribute}" do
        it "returns the video #{attribute}" do
          video.stub(:fetch) { double(attribute => expected_value) }
          expect(video.send(attribute)).to eql(expected_value)
        end
      end
    end

    describe "#thumbnail_small" do
      let(:thumbnail_small) { 'http://example.org/small_thumb.jpg' }
      it "returns the video thumbnail_small" do
        video.stub(:fetch) {
          double(thumbnails:[double(url: thumbnail_small)])
        }
        expect(video.thumbnail_small).to eql(thumbnail_small)
      end
    end

    describe "#thumbnail_medium" do
      let(:thumbnail_medium) { 'http://example.org/medium_thumb.jpg' }
      it "returns the video thumbnail_medium" do
        video.stub(:fetch) {
          double(thumbnails:[nil, double(url: thumbnail_medium)])
        }
        expect(video.thumbnail_medium).to eql(thumbnail_medium)
      end
    end

    describe "#thumbnail_large" do
      let(:thumbnail_large) { 'http://example.org/large_thumb.jpg' }
      it "returns the video thumbnail_large" do
        video.stub(:fetch) {
          double(thumbnails:[nil, nil, double(url: thumbnail_large)])
        }
        expect(video.thumbnail_large).to eql(thumbnail_large)
      end
    end
  end

end
