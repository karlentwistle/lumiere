require_relative '../lib/playlist'

module Lumiere
  describe Playlist do

    describe ".page_count" do
      subject(:pages) { (Playlist.page_count(total, per_page)) }

      context "total: 100, per_page: 25" do
        let(:total) { 100 }
        let(:per_page) { 25 }

        it "returns 4" do
          expect(pages).to eql(4)
        end
      end

      context "total: 100, per_page: 50" do
        let(:total) { 100 }
        let(:per_page) { 50 }

        it "returns 2" do
          expect(pages).to eql(2)
        end
      end

      context "total: 13, per_page: 3" do
        let(:total) { 13 }
        let(:per_page) { 3 }

        it "returns 5" do
          expect(pages).to eql(5)
        end
      end

      context "total: 13, per_page: 5" do
        let(:total) { 13 }
        let(:per_page) { 5 }

        it "returns 3" do
          expect(pages).to eql(3)
        end
      end

      context "total: 12, per_page: 14" do
        let(:total) { 12 }
        let(:per_page) { 14 }

        it "returns 1" do
          expect(pages).to eql(1)
        end
      end
    end

  end
end
