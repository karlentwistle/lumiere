require 'spec_helper'
require_relative '../../lib/provider/dailymotion/dailymotion'

def valid_urls
  {
    'x4abi7' => 'http://www.dailymotion.com/embed/video/x4abi7',
    'y7wqi3' => 'http://dailymotion.com/embed/video/y7wqi3',
    'z7lba3' => 'https://www.dailymotion.com/embed/video/z7lba3',
    'a7wqf3' => 'https://dailymotion.com/embed/video/a7wqf3',
    'w31uma' => 'https://www.dailymotion.com/video/w31uma',
    't87umd' => 'https://dailymotion.com/video/t87umd',
    'h31umd' => 'http://www.dailymotion.com/video/h31umd',
    'p31umd' => 'http://dailymotion.com/video/p31umd',
    'y2a6vz5' => 'https://www.dailymotion.com/video/y2a6vz5_pigeon-remi-gaillard-extrait-du-film_fun',
    'u8jt3s6' => 'dailymotion.com/video/u8jt3s6_la-capote-a-craque_fun',
    'd1rjzxt' => '//dailymotion.com/video/d1rjzxt_la-superbe-lucarne-de-cristiano-ronaldo_sport',
    'x1pd4nn' => '//www.dailymotion.com/embed/video/x1pd4nn',
  }
end

module Lumiere
  describe Vimeo do
    subject(:video) { Dailymotion.new('//www.dailymotion.com/embed/video/x1pd4nn') }

    describe ".useable?" do
      context "valid" do
        valid_urls.each_value do |url|
          context "#{url}" do
            it "returns true" do
              expect(Dailymotion.useable?(url)).to eql(true)
            end
          end
        end
      end
    end

    it "stores url" do
      expect(Dailymotion.new('//www.dailymotion.com/embed/video/x1pd4nn').url).
        to eql('//www.dailymotion.com/embed/video/x1pd4nn')
    end

    describe "#video_id" do
      valid_urls.each do |video_id, url|
        context url do
          it "extracts the video_id #{video_id}" do
            expect(Dailymotion.new(url).video_id).to eql(video_id)
          end
        end
      end
    end

    describe "#provider" do
      it "returns Dailymotion" do
        expect(video.provider).to eql("Dailymotion")
      end
    end

    describe "#api_url" do
      it "returns the url of the Dailymotion api" do
        expect(video.api_url).
          to eql('https://api.dailymotion.com/video/x1pd4nn?fields=id,title,description,duration,created_time,url,thumbnail_720_url,thumbnail_240_url,thumbnail_60_url')
      end
    end

#<iframe frameborder="0" width="480" height="270" src="//www.dailymotion.com/embed/video/x1pd4nn" allowfullscreen></iframe>

    describe "#embed_url" do
      it "returns the embed_url" do
        expect(video.embed_url).to eql('http://www.dailymotion.com/embed/video/x1pd4nn')
      end
    end

    describe "#embed_code" do
      it "returns the embed_code" do
        expect(video.embed_code).
          to eql('<iframe frameborder="0" src="//www.dailymotion.com/embed/video/x1pd4nn" allowfullscreen></iframe>')
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
