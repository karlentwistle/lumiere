require 'spec_helper'

module Lumiere
  describe YouTube do
    let(:description) { 'Description of my awesome Video' }
    let(:title) { 'Title of my awesome Video' }
    let(:thumbnail_small) { 'Thumbnail Small' }
    let(:thumbnail_medium) { 'Thumbnail Medium' }
    let(:thumbnail_large) { 'Thumbnail Large' }
    let(:duration) { 35 }
    let(:remote_structure) {
      {
        'entry' => {
          'title' => {'$t' => title},
          'media$group' => {
            'media$thumbnail' => [
              {'url' => thumbnail_small},
              {'url' => thumbnail_medium},
              {'url' => thumbnail_large},
            ],
            'media$description' => {
              '$t' => description
            },
            'yt$duration' => {
              'seconds' => "#{duration}"
            },
          }
        }
      }
    }

    subject(:video) { YouTube.new('VIDEO_ID') }

    before do
      video.stub(:remote_structure) { remote_structure }
    end

    describe ".useable?" do
      valid_urls = [
        'http://www.youtube.com/watch?v=Xp6CXF',
        'https://www.youtube.com/watch?v=Xp6CXF',
        'www.youtube.com/watch?v=Xp6CXF',
        'http://youtube.com/watch?v=Xp6CXF',
        'https://youtube.com/watch?v=Xp6CXF',
        'youtube.com/watch?v=Xp6CXF',
        'http://youtu.be/JM9NgvjjVng',
        'https://youtu.be/JM9NgvjjVng',
        'youtu.be/JM9NgvjjVng'
      ]
      valid_urls.each do |url|
        context "valid" do
          context "#{url}" do
            it "returns true" do
              expect(YouTube.usable?(url)).to be_true
            end
          end
        end
      end
    end


    it "stores id" do
      expect(YouTube.new(1).id).to eql(1)
    end

    describe "#api_url" do
      it "returns the url of the YouTube api" do
        expect(YouTube.new('VIDEO_ID').api_url).
          to eql('http://gdata.youtube.com/feeds/api/videos/VIDEO_ID?v=2&alt=json')
      end
    end

    describe "#embed_url" do
      it "returns the embed_url" do
        expect(video.embed_url).to eql('http://www.youtube.com/embed/VIDEO_ID')
      end
    end

    describe "#embed_code" do
      it "returns the embed_code" do
        expect(video.embed_code).
          to eql('<iframe src="//www.youtube.com/embed/VIDEO_ID" frameborder="0" allowfullscreen></iframe>')
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
