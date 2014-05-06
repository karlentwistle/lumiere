require 'spec_helper'

module Lumiere
  describe Elluminate, :vcr do
    context "Vimeo 4268592" do
      let(:url) { 'https://vimeo.com/4268592' }
      subject(:video) { Elluminate.new(url) }

      it "is useable" do
        expect(Elluminate.useable?(url)).to be_true
      end

      it do
        expect(video.provider).to eql('Vimeo')
        expect(video.title).to eql('Alan Watts')
        expect(video.description).to eql("Alan Watts&#13;<br />\n&#13;<br />\n&#13;<br />\nSo true.&#13;")
        expect(video.upload_date).to eql(DateTime.parse("2009-04-21 20:22:09"))
        expect(video.video_id).to eql('4268592')
        expect(video.duration).to eql(141)
        expect(video.accessible?).to eql(true)
        expect(video.thumbnail_small).to eql('http://i.vimeocdn.com/video/9464045_100x75.jpg')
        expect(video.thumbnail_medium).to eql('http://i.vimeocdn.com/video/9464045_200x150.jpg')
        expect(video.thumbnail_large).to eql('http://i.vimeocdn.com/video/9464045_640.jpg')
      end
    end

    context "Vimeo Playlist 4268592" do
      let(:url) { 'https://vimeo.com/album/1488772' }
      subject(:playlist) { Elluminate.new('https://vimeo.com/album/1488772') }

      it "is useable" do
        expect(Elluminate.useable?(url)).to be_true
      end

      it do
        expect(playlist.provider).to eql('Vimeo')
        expect(playlist.title).to eql('STEPHEN HAWKING\'S UNIVERSE')
        expect(playlist.description).to eql("Descubre el universo de la mano de Stephen Hawking. Con 6 episodios, nos explica los secretos del Universo, la formaci\u00f3n de los planetas,\u2026")
        expect(playlist.upload_date).to eql(DateTime.parse("2010-12-08T06:37:55+00:00"))
        expect(playlist.playlist_id).to eql('1488772')
        expect(playlist.accessible?).to eql(true)
        expect(playlist.thumbnail_small).to eql('http://i.vimeocdn.com/video/134668334_100x75.jpg')
        expect(playlist.thumbnail_medium).to eql('http://i.vimeocdn.com/video/134668334_200x150.jpg')
        expect(playlist.thumbnail_large).to eql('http://i.vimeocdn.com/video/134668334_640.jpg')

        expect(playlist.videos).to match_array([
          Vimeo.new('http://vimeo.com/17385851'),
          Vimeo.new('http://vimeo.com/17384125'),
          Vimeo.new('http://vimeo.com/17571029'),
          Vimeo.new('http://vimeo.com/17581126'),
          Vimeo.new('http://vimeo.com/17814855'),
          Vimeo.new('http://vimeo.com/17838622'),
        ])
      end
    end

    context "Vimeo Playlist 2356816" do
      subject(:playlist) { Elluminate.new('//vimeo.com/album/2356816') }

      it do
        expect(playlist.videos.size).to eql(60) # this is a fundemental limitition in the simple vimeo api
      end
    end

    context "YouTube NwRuI0yjreQ" do
      let(:url) { 'https://www.youtube.com/watch?v=NwRuI0yjreQ' }
      subject(:video) { Elluminate.new(url) }

      it "is useable" do
        expect(Elluminate.useable?(url)).to be_true
      end

      it do
        expect(video.provider).to eql('YouTube')
        expect(video.title).to eql('Shock haircut Supermodel punishment')
        expect(video.description).to eql("Supermodels are forced to cut their long locks and burst into tears. Fashion makeover or Punishment?")
        expect(video.upload_date).to eql(DateTime.parse("2013-12-23T11:50:34.000Z"))
        expect(video.video_id).to eql('NwRuI0yjreQ')
        expect(video.duration).to eql(419)
        expect(video.accessible?).to eql(true)
        expect(video.thumbnail_small).to eql('http://i1.ytimg.com/vi/NwRuI0yjreQ/default.jpg')
        expect(video.thumbnail_medium).to eql('http://i1.ytimg.com/vi/NwRuI0yjreQ/mqdefault.jpg')
        expect(video.thumbnail_large).to eql('http://i1.ytimg.com/vi/NwRuI0yjreQ/hqdefault.jpg')
      end
    end

    context "YouTube Playlist 63F0C78739B09958" do
      let(:url) { 'https://www.youtube.com/playlist?p=63F0C78739B09958' }
      subject(:playlist) { Elluminate.new(url) }

      it "is useable" do
        expect(Elluminate.useable?(url)).to be_true
      end

      it do
        expect(playlist.provider).to eql('YouTube')
        expect(playlist.title).to eql('Music Playlist')
        expect(playlist.description).to eql("Playlist just brimming with the odd, beautiful, or interesting music videos I come across")
        expect(playlist.accessible?).to eql(true)
        expect(playlist.playlist_id).to eql('63F0C78739B09958')
        expect(playlist.thumbnail_small).to eql('http://i.ytimg.com/vi/nyMkLwSyOVQ/default.jpg')
        expect(playlist.thumbnail_medium).to eql('http://i.ytimg.com/vi/nyMkLwSyOVQ/mqdefault.jpg')
        expect(playlist.thumbnail_large).to eql('http://i.ytimg.com/vi/nyMkLwSyOVQ/hqdefault.jpg')

        expect(playlist.videos).to match_array([
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
      subject(:playlist) { Elluminate.new('https://www.youtube.com/playlist?p=PL44955DED6D0262DB') }

      it do
        expect(playlist.videos.size).to eql(199) # the deleted video doesnt count
      end
    end

    context "YouTube Playlist PLGznEl712WekhqwD9jh3YXR-cJTjSBVjQ" do
      subject(:playlist) { Elluminate.new('https://www.youtube.com/playlist?p=PLGznEl712WekhqwD9jh3YXR-cJTjSBVjQ') }

      it do
        expect(playlist.videos.size).to eql(200)
      end
    end

    context "Dailymotion x1dh5lh" do
      let(:url) { 'http://www.dailymotion.com/video/x1dh11z_vintage-otis-hydraulic-elevator-at-saks-fifth-avenue-frontenac-plaza-frontenac-mo_fun' }
      subject(:video) { Elluminate.new(url) }

      it "is useable" do
        expect(Elluminate.useable?(url)).to be_true
      end

      it do
        expect(video.provider).to eql('Dailymotion')
        expect(video.title).to eql('Vintage Otis Hydraulic Elevator at Saks Fifth Avenue, Frontenac Plaza, Frontenac, MO')
        expect(video.description).to eql('[Featuring Dieselducy]  Andrew and I took a ride an an older Otis Lexan in FANTASTIC condition.')
        expect(video.accessible?).to eql(true)
        expect(video.video_id).to eql('x1dh11z')
        expect(video.duration).to eql(172)
        expect(video.thumbnail_small).to eql('http://s1.dmcdn.net/Evju5/x60-mG0.jpg')
        expect(video.thumbnail_medium).to eql('http://s1.dmcdn.net/Evju5/x240-Dgb.jpg')
        expect(video.thumbnail_large).to eql('http://s1.dmcdn.net/Evju5/x720-5Nl.jpg')
      end
    end

  end
end
