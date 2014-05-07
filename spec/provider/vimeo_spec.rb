require_relative '../../lib/provider/vimeo/vimeo'

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
    subject(:video) { Vimeo.new('https://vimeo.com/12345') }

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
        expect(video.api_url).
          to eql('http://vimeo.com/api/v2/video/12345.json')
      end
    end

    describe "#embed_url" do
      it "returns the embed_url" do
        expect(video.embed_url).to eql('//player.vimeo.com/video/12345')
      end
    end

    describe "#embed_code" do
      context "no options" do
        it "returns the embed_code with the default options" do
          expect(video.embed_code).
            to eql('<iframe src="//player.vimeo.com/video/12345" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>')
        end
      end

      context "options" do
        it "returns the embed_code with options appended to defaults" do
          expect(video.embed_code(iframe_attributes: {width: 800, height: 600})).
            to eql('<iframe src="//player.vimeo.com/video/12345" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen width="800" height="600"></iframe>')
        end
      end
    end

    remotes = {
      title: 'awesome title',
      description: 'awesome description',
      duration: '54',
      upload_date: Date.today,
      thumbnail_small: 'http://example.org/small_thumb.jpg',
      thumbnail_medium: 'http://example.org/medium_thumb.jpg',
      thumbnail_large: 'http://example.org/large_thumb.jpg',
    }.each do |attribute, expected_value|
      describe "##{attribute}" do
        it "returns the video #{attribute}" do
          video.stub(:fetch) { double(attribute => expected_value) }
          expect(video.send(attribute)).to eql(expected_value)
        end
      end
    end

  end
end
