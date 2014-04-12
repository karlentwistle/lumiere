require 'spec_helper'

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

    before do
      video.stub(:remote_structure) { remote_structure }
    end

    it "stores id" do
      expect(Vimeo.new(1).id).to eql(1)
    end

    describe "#api_url" do
      it "returns the url of the Vimeo api" do
        expect(Vimeo.new('VIDEO_ID').api_url).
          to eql('http://vimeo.com/api/v2/video/VIDEO_ID.json')
      end
    end

    describe "#embed_url" do
      it "returns the embed_url" do
        expect(video.embed_url).to eql('http://player.vimeo.com/video/VIDEO_ID')
      end
    end

    describe "#embed_code" do
      it "returns the embed_code" do
        expect(video.embed_code).
          to eql('<iframe src="//player.vimeo.com/video/VIDEO_ID" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>')
      end
    end

    describe "#title" do
      it "returns the video title" do
        expect(video.title).to eql(title)
      end
    end

    describe "#description" do
      it "returns the video description" do
        expect(video.description).to eql(description)
      end
    end

    describe "#duration" do
      it "returns the video duration" do
        expect(video.duration).to eql(duration)
      end
    end

    describe "#thumbnail_small" do
      it "returns the video thumbnail_small" do
        expect(video.thumbnail_small).to eql(thumbnail_small)
      end
    end

    describe "#thumbnail_medium" do
      it "returns the video thumbnail_medium" do
        expect(video.thumbnail_medium).to eql(thumbnail_medium)
      end
    end

    describe "#thumbnail_large" do
      it "returns the video thumbnail_large" do
        expect(video.thumbnail_large).to eql(thumbnail_large)
      end
    end
  end

end
