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
  end

end
