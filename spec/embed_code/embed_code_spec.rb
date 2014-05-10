require_relative '../../lib/embed_code/embed_code'

module Lumiere
  class FakeVideoHost
    include EmbedCode

    def embed_url
      '/remote'
    end

    def default_attributes
      {
        iframe_attributes: {  },
        url_attributes: {  }
      }
    end
  end

  describe EmbedCode do
    describe ".embed_code" do
      context "no options" do
        subject(:embed_code) { (FakeVideoHost.new.embed_code) }
        it 'returns iframe with src' do
          expect(embed_code).to eql('<iframe src="/remote"></iframe>')
        end
      end

      context "url_attributes" do
        context "single option passed" do
          subject(:embed_code) { (FakeVideoHost.new.embed_code(opts)) }
          let(:opts) { { url_attributes: { autoplay: 1 } } }
          it 'returns iframe with src and option appended to it' do
            expect(embed_code).to eql('<iframe src="/remote?autoplay=1"></iframe>')
          end
        end

        context "multiple options passed" do
          subject(:embed_code) { (FakeVideoHost.new.embed_code(opts)) }
          let(:opts) { { url_attributes: { autoplay: 1, reuben: 'yeah' } } }
          it 'returns iframe with src and options appended to it' do
            expect(embed_code).to eql('<iframe src="/remote?autoplay=1&reuben=yeah"></iframe>')
          end
        end
      end

      context "iframe_attributes" do
        context "single option passed" do
          subject(:embed_code) { (FakeVideoHost.new.embed_code(opts)) }
          let(:opts) { { iframe_attributes: {width: 200} } }
          it 'returns iframe with src and option' do
            expect(embed_code).to eql('<iframe src="/remote" width="200"></iframe>')
          end
        end

        context "multiple options passed" do
          subject(:embed_code) { (FakeVideoHost.new.embed_code(opts)) }
          let(:opts) { { iframe_attributes: {width: 200, height: 300} } }
          it 'returns iframe with src and options' do
            expect(embed_code).to eql('<iframe src="/remote" width="200" height="300"></iframe>')
          end
        end

        context "boolean option passed" do
          subject(:embed_code) { (FakeVideoHost.new.embed_code(opts)) }
          context "true" do
            let(:opts) { { iframe_attributes: {allowfullscreen: true} } }
            it 'returns iframe with src and boolean option set as "option" rather than "option=true"' do
              expect(embed_code).to eql('<iframe src="/remote" allowfullscreen></iframe>')
            end
          end
        end
      end
    end
  end
end
