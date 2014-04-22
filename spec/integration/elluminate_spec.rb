require 'spec_helper'

module Lumiere
  describe Elluminate, :vcr do
    context "Vimeo 4268592" do
    subject(:video) { Elluminate.new('https://vimeo.com/4268592') }
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

    context "YouTube NwRuI0yjreQ" do
    subject(:video) { Elluminate.new('https://www.youtube.com/watch?v=NwRuI0yjreQ') }
      it do
        expect(video.title).to eql('Shock haircut Supermodel punishment')
        expect(video.description).to eql("Supermodels are forced to cut their long locks and burst into tears. Fashion makeover or Punishment?")
        expect(video.duration).to eql(419)
        expect(video.accessible?).to eql(true)
        expect(video.thumbnail_small).to eql('http://i1.ytimg.com/vi/NwRuI0yjreQ/default.jpg')
        expect(video.thumbnail_medium).to eql('http://i1.ytimg.com/vi/NwRuI0yjreQ/mqdefault.jpg')
        expect(video.thumbnail_large).to eql('http://i1.ytimg.com/vi/NwRuI0yjreQ/hqdefault.jpg')
      end
    end

    context "YouTube Playlist 63F0C78739B09958" do
    subject(:video) { Elluminate.new('https://www.youtube.com/playlist?p=63F0C78739B09958') }
      it do
        expect(video.title).to eql('Music Playlist')
        expect(video.description).to eql("Playlist just brimming with the odd, beautiful, or interesting music videos I come across")
        expect(video.accessible?).to eql(true)
        expect(video.thumbnail_small).to eql('http://i.ytimg.com/vi/nyMkLwSyOVQ/default.jpg')
        expect(video.thumbnail_medium).to eql('http://i.ytimg.com/vi/nyMkLwSyOVQ/mqdefault.jpg')
        expect(video.thumbnail_large).to eql('http://i.ytimg.com/vi/nyMkLwSyOVQ/hqdefault.jpg')

        expect(video.videos).to match_array([
          YouTube.new('http://www.youtube.com/watch?v=nyMkLwSyOVQ'),
          YouTube.new('http://www.youtube.com/watch?v=2_HXUhShhmY'),
          YouTube.new('http://www.youtube.com/watch?v=lLJf9qJHR3E'),
          YouTube.new('http://www.youtube.com/watch?v=j9e38cuhnaU'),
          YouTube.new('http://www.youtube.com/watch?v=MZAKjKC7Gho'),
          YouTube.new('http://www.youtube.com/watch?v=vLrslkB1pG8'),
          YouTube.new('http://www.youtube.com/watch?v=JWiwuiT58Yc'),
          YouTube.new('http://www.youtube.com/watch?v=yFTvbcNhEgc'),
        ])
      end
    end

    context "YouTube Playlist PL44955DED6D0262DB" do
      subject(:video) { Elluminate.new('https://www.youtube.com/playlist?p=PL44955DED6D0262DB') }

      it do
        expect(video.videos.size).to eql(199) # the deleted video doesnt count
      end

    end

  end
end
