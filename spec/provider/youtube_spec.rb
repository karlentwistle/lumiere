require 'spec_helper'

module Lumiere
  describe YouTube do
    let(:description) { 'Description of my awesome Video' }
    let(:title) { 'Title of my awesome Video' }
    let(:duration) { 35 }
    let(:remote_structure) {
      {
        'entry' => {
          'title' => {'$t' => title},
          'media$group' => {
            'media$description' => {
              '$t' => description
            },
            'yt$duration' => {
              'seconds' => "#{duration}"
            }
          }
        }
      }
    }

    it "stores id" do
      expect(YouTube.new(1).id).to eql(1)
    end

    describe ".api_url" do
      it "returns the url of the YouTube api" do
        expect(YouTube.new('VIDEO_ID').api_url).
          to eql('http://gdata.youtube.com/feeds/api/videos/VIDEO_ID?v=2&alt=json')
      end
    end

    describe "#accessible?" do
      context "private video" do
        it "returns false" do
          stub_request(:any, "http://gdata.youtube.com/feeds/api/videos/PRIVATE_VIDEO?alt=json&v=2").to_return(status: 403)
          VCR.turned_off { expect(YouTube.new('PRIVATE_VIDEO').accessible?).to be_false }
        end
      end

      context "dmca video" do
        it "returns false" do
          stub_request(:any, "http://gdata.youtube.com/feeds/api/videos/DMCA_VIDEO?alt=json&v=2").to_return(status: 403)
          VCR.turned_off { expect(YouTube.new('DMCA_VIDEO').accessible?).to be_false }
        end
      end

      context "removed video" do
        it "returns false" do
          stub_request(:any, "http://gdata.youtube.com/feeds/api/videos/DMCA_VIDEO?alt=json&v=2").to_return(status: 404)
          VCR.turned_off { expect(YouTube.new('DMCA_VIDEO').accessible?).to be_false }
        end
      end

      context "public video" do
        it "returns true" do
          stub_request(:any, "gdata.youtube.com").to_return(status: 200)
          stub_request(:any, "http://gdata.youtube.com/feeds/api/videos/PUBLIC_VIDEO?alt=json&v=2").to_return(status: 200)
          VCR.turned_off { expect(YouTube.new('PUBLIC_VIDEO').accessible?).to be_true }
        end
      end
    end

    describe "#title" do
      it "returns the video title" do
        Lumiere.stub(:remote_structure) { remote_structure }
        expect(YouTube.new('VIDEO_ID').title).to eql(title)
      end
    end

    describe "#description" do
      it "returns the video description" do
        Lumiere.stub(:remote_structure) { remote_structure }
        expect(YouTube.new('VIDEO_ID').description).to eql(description)
      end
    end

    describe "#duration" do
      it "returns the video duration" do
        Lumiere.stub(:remote_structure) { remote_structure }
        expect(YouTube.new('VIDEO_ID').duration).to eql(duration)
      end
    end


  end

end
