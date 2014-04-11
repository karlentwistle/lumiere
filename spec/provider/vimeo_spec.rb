require 'spec_helper'

module Lumiere
  describe Vimeo do
    let(:description) { 'Description of my awesome Video' }
    let(:title) { 'Title of my awesome Video' }
    let(:duration) { 35 }
    let(:remote_structure) {
      [
        {
          'title' => title,
          'description' => description,
          'duration' => duration
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

    describe ".api_url" do
      it "returns the url of the Vimeo api" do
        expect(Vimeo.new('VIDEO_ID').api_url).
          to eql('http://vimeo.com/api/v2/video/VIDEO_ID.json')
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

  end

end
