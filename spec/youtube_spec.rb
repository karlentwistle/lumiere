require 'spec_helper'

module Lumiere

  describe YouTube do

    it "stores id" do
      expect(YouTube.new(1).id).to eql(1)
    end

    describe ".api_url" do
      it "returns the url of the YouTube api" do
        expect(YouTube.new('VIDEO_ID').api_url).
          to eql('http://gdata.youtube.com/feeds/api/videos/VIDEO_ID?v=2&alt=json')
      end
    end

    describe "#title" do
      it "returns the video title" do
        allow(Lumiere).to receive(:fetch_title) { 'Title of Video' }
        expect(YouTube.new('VIDEO_ID').title).to eql('Title of Video')
      end
    end

    describe "#title" do
      let(:title) { 'Title of Video' }
      it "returns the video title" do
        allow(Lumiere).to receive(:fetch_title) { title }
        expect(YouTube.new('VIDEO_ID').title).to eql(title)
      end
    end

    describe "#description" do
      let(:description) { 'Description of my awesome Video' }
      it "returns the video description" do
        allow(Lumiere).to receive(:fetch_description) { description }
        expect(YouTube.new('VIDEO_ID').description).to eql(description)
      end
    end

  end

end
