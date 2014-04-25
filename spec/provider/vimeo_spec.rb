require 'spec_helper'

def valid_urls
  {
    '89682547' => 'https://www.vimeo.com/89682547',
    '8968222' => 'www.vimeo.com/8968222',
    '10000' => 'http://vimeo.com/10000',
    '99999' => 'https://vimeo.com/99999',
    '80' => 'vimeo.com/80',
    '92224516' => '//player.vimeo.com/video/92224516?badge=0',
    '15468' => 'http://player.vimeo.com/video/15468',
    '10' =>'player.vimeo.com/video/10',
    '999' =>'http://player.vimeo.com/video/999',
    '1010' =>'http://player.vimeo.com/video/1010',
  }
end

module Lumiere
  describe Vimeo do
    subject(:video) { Vimeo.new('VIDEO_ID') }

    describe ".new_from_video_id" do
      it "returns a new Vimeo object with a .useable? url" do
        expect(Vimeo.new_from_video_id(1)).to eq(Vimeo.new('http://vimeo.com/1'))
      end
    end

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

    describe "#provider" do
      it "returns Vimeo" do
        expect(video.provider).to eql("Vimeo")
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
      let(:title) { 'awesome title' }
      let(:remote_structure) { [ { title: title } ].to_json }
      it "returns the video title" do
        video.stub(:raw_response) { remote_structure }
        expect(video.title).to eql(title)
      end
    end

    describe "#description" do
      let(:description) { 'awesome description' }
      let(:remote_structure) { [ { description: description } ].to_json }
      it "returns the video description" do
        video.stub(:raw_response) { remote_structure }
        expect(video.description).to eql(description)
      end
    end

    describe "#duration" do
      let(:duration) { '54' }
      let(:remote_structure) { [ { duration: duration } ].to_json }
      it "returns the video duration" do
        video.stub(:raw_response) { remote_structure }
        expect(video.duration).to eql(duration.to_i)
      end
    end

    describe "#upload_date" do
      let(:upload_date) { Date.today }
      let(:remote_structure) { [ { upload_date: upload_date } ].to_json }
      it "returns the date the video was uploaded" do
        video.stub(:raw_response) { remote_structure }
        expect(video.upload_date).to eql(upload_date)
      end
    end

    describe "#thumbnail_small" do
      let(:thumbnail_small) { 'http://example.org/small_thumb.jpg' }
      let(:remote_structure) { [ { thumbnail_small: thumbnail_small } ].to_json }
      it "returns the video thumbnail_small" do
        video.stub(:raw_response) { remote_structure }
        expect(video.thumbnail_small).to eql(thumbnail_small)
      end
    end

    describe "#thumbnail_medium" do
      let(:thumbnail_medium) { 'http://example.org/medium_thumb.jpg' }
      let(:remote_structure) { [ { thumbnail_medium: thumbnail_medium } ].to_json }
      it "returns the video thumbnail_medium" do
        video.stub(:raw_response) { remote_structure }
        expect(video.thumbnail_medium).to eql(thumbnail_medium)
      end
    end

    describe "#thumbnail_large" do
      let(:thumbnail_large) { 'http://example.org/large_thumb.jpg' }
      let(:remote_structure) { [ { thumbnail_large: thumbnail_large } ].to_json }
      it "returns the video thumbnail_large" do
        video.stub(:raw_response) { remote_structure }
        expect(video.thumbnail_large).to eql(thumbnail_large)
      end
    end
  end

end
