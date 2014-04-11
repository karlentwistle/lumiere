require 'spec_helper'

module Lumiere
  describe Vimeo, :vcr do
    subject(:video) { Vimeo.new('4268592') }

    context "4268592" do
      it do
        expect(video.title).to eql('Alan Watts')
        expect(video.description).to eql("Alan Watts&#13;<br />\n&#13;<br />\n&#13;<br />\nSo true.&#13;")
        expect(video.duration).to eql(141)
        expect(video.accessible?).to eql(true)
        expect(video.thumbnail_small).to eql('http://i.vimeocdn.com/video/9464045_100x75.jpg')
        expect(video.thumbnail_medium).to eql('http://i.vimeocdn.com/video/9464045_200x150.jpg')
        expect(video.thumbnail_large).to eql('http://i.vimeocdn.com/video/9464045_640.jpg')
      end
    end
  end
end



