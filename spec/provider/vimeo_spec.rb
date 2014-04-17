require 'spec_helper'

def valid_urls
  {
    '89682547' => 'https://www.vimeo.com/89682547',
    '8968222' => 'www.vimeo.com/8968222',
    '10000' => 'http://vimeo.com/10000',
    '99999' => 'https://vimeo.com/99999',
    '80' => 'vimeo.com/80',
  }
end

module Lumiere
  describe Vimeo do
    let(:description) { 'Description of my awesome Video' }
    let(:title) { 'Title of my awesome Video' }
    let(:thumbnail_small) { 'Thumbnail Small' }
    let(:thumbnail_medium) { 'Thumbnail Medium' }
    let(:thumbnail_large) { 'Thumbnail Large' }
    let(:duration) { 35 }
    let(:remote_structure) {
      [
        {
          'title' => title,
          'description' => description,
          'duration' => duration,
          'thumbnail_small' => thumbnail_small,
          'thumbnail_medium' => thumbnail_medium,
          'thumbnail_large' => thumbnail_large,
        }
      ]
    }

    subject(:video) { Vimeo.new('VIDEO_ID') }

    describe ".useable?" do
      context "valid" do
        valid_urls.each_value do |url|
          context "#{url}" do
            it "returns true" do
              expect(Vimeo.useable?(url)).to eql(true)
            end
          end
        end
      end
    end

    it "stores url" do
      expect(Vimeo.new('www.vimeo.com/4268592').url).to eql('www.vimeo.com/4268592')
    end

    describe "video_id" do
      valid_urls.each do |video_id, url|
        context url do
          it "extracts the video_id" do
            expect(Vimeo.new(url).video_id).to eql(video_id)
          end
        end
      end
    end

    describe "#api_url" do
      it "returns the url of the Vimeo api" do
        video.stub(:video_id) { 'VIDEO_ID' }
        expect(video.api_url).
          to eql('http://vimeo.com/api/v2/video/VIDEO_ID.json')
      end
    end

    describe "#embed_url" do
      it "returns the embed_url" do
        video.stub(:video_id) { 'VIDEO_ID' }
        expect(video.embed_url).to eql('http://player.vimeo.com/video/VIDEO_ID')
      end
    end

    describe "#embed_code" do
      it "returns the embed_code" do
        video.stub(:video_id) { 'VIDEO_ID' }
        expect(video.embed_code).
          to eql('<iframe src="//player.vimeo.com/video/VIDEO_ID" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>')
      end
    end

    describe "#title" do
      it "returns the video title" do
        video.stub(:fetch) { OpenStruct.new(remote_structure[0]) }
        expect(video.title).to eql(title)
      end
    end

    describe "#description" do
      it "returns the video description" do
        video.stub(:fetch) { OpenStruct.new(remote_structure[0]) }
        expect(video.description).to eql(description)
      end
    end

    describe "#duration" do
      it "returns the video duration" do
        video.stub(:fetch) { OpenStruct.new(remote_structure[0]) }
        expect(video.duration).to eql(duration)
      end
    end

    describe "#thumbnail_small" do
      it "returns the video thumbnail_small" do
        video.stub(:fetch) { OpenStruct.new(remote_structure[0]) }
        expect(video.thumbnail_small).to eql(thumbnail_small)
      end
    end

    describe "#thumbnail_medium" do
      it "returns the video thumbnail_medium" do
        video.stub(:fetch) { OpenStruct.new(remote_structure[0]) }
        expect(video.thumbnail_medium).to eql(thumbnail_medium)
      end
    end

    describe "#thumbnail_large" do
      it "returns the video thumbnail_large" do
        video.stub(:fetch) { OpenStruct.new(remote_structure[0]) }
        expect(video.thumbnail_large).to eql(thumbnail_large)
      end
    end
  end

end
