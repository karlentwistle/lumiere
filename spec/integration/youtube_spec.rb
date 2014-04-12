require 'spec_helper'

module Lumiere
  describe YouTube, :vcr do
    subject(:video) { Elluminate.new('https://www.youtube.com/watch?v=NwRuI0yjreQ') }

    context "NwRuI0yjreQ" do
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
  end
end



