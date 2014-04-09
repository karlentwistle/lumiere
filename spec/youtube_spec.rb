require 'spec_helper'

module Lumiere

  describe YouTube do

    it "stores id" do
      expect(YouTube.new(1).id).to eql(1)
    end

    describe "#title" do
      it "returns the video title" do
        expect(Lumiere).to receive(:fetch_title).with('0fKBhvDjuy0') { 'Powers of Ten™ (1977)' }
        expect(YouTube.new('0fKBhvDjuy0').title).to eql('Powers of Ten™ (1977)')
      end
    end
  end

end
