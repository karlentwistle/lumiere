require_relative '../lib/embed_code'

module Lumiere
  describe EmbedCode do

    describe ".generate" do
      subject(:pages) { (EmbedCode.generate('/remote', opts)) }

      context "no options" do
        let(:opts) { nil }
        it 'returns iframe with src' do
          expect(pages).to eql('<iframe src="/remote"></iframe>')
        end
      end

      context "single option passed" do
        let(:opts) { {width: 200} }
        it 'returns iframe with src and option' do
          expect(pages).to eql('<iframe src="/remote" width="200"></iframe>')
        end
      end

      context "multiple options passed" do
        let(:opts) { {width: 200, height: 300} }
        it 'returns iframe with src and options' do
          expect(pages).to eql('<iframe src="/remote" width="200" height="300"></iframe>')
        end
      end

      context "boolean option passed" do
        context "true" do
          let(:opts) { {allowfullscreen: true} }
          it 'returns iframe with src and boolean option set as "option" rather than "option=true"' do
            expect(pages).to eql('<iframe src="/remote" allowfullscreen></iframe>')
          end
        end
      end
    end

  end
end
