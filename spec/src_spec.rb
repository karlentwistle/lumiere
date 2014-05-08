require_relative '../lib/src'

module Lumiere

  describe SRC do
    describe ".encode" do
      let(:original_src) { 'http://www.example.com/' }
      subject(:generated_src) { SRC.encode(original_src) }

      context "no options" do
        it 'returns unchanged src' do
          expect(generated_src).to eql(original_src)
        end
      end

      context "options passed" do
        subject(:generated_src) { SRC.encode(original_src, opts) }

        context "blank" do
          let(:opts) { { } }
          it 'returns unchanged src' do
            expect(generated_src).to eql(original_src)
          end
        end

        context "single" do
          let(:opts) { { autoplay: 1 } }
          it 'returns src with passed options appended as a valid URL' do
            expect(generated_src).to eql('http://www.example.com/?autoplay=1')
          end
        end

        context "multiple" do
          let(:opts) { { autoplay: 1, reuben: 'yeah' } }
          it 'returns src with passed options appended as a valid URL' do
            expect(generated_src).to eql('http://www.example.com/?autoplay=1&reuben=yeah')
          end
        end
      end
    end
  end
end
