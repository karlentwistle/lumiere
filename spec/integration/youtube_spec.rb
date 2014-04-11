require 'spec_helper'

module Lumiere
  describe YouTube, :vcr do
    subject(:video) { YouTube.new('NwRuI0yjreQ') }

    context "NwRuI0yjreQ" do
      it do
        expect(video.title).to eql('Shock haircut Supermodel punishment')
        expect(video.description).to eql("Supermodels are forced to cut their long locks and burst into tears. Fashion makeover or Punishment?")
      end
    end
  end
end



