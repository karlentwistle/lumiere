require 'spec_helper'

module Lumiere
  describe Vimeo do
    let(:description) { 'Description of my awesome Video' }
    let(:title) { 'Title of my awesome Video' }
    let(:remote_structure) {
      [{
        'title' => title,
        'description' => description
      }]
    }

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
      let(:title) { 'Title of Video' }
      it "returns the video title" do
        Lumiere.stub(:remote_structure) { remote_structure }
        expect(Vimeo.new('VIDEO_ID').title).to eql(title)
      end
    end

    describe "#description" do
      let(:description) { 'Description of my awesome Video' }
      it "returns the video description" do
        Lumiere.stub(:remote_structure) { remote_structure }
        expect(Vimeo.new('VIDEO_ID').description).to eql(description)
      end
    end

  end

end
