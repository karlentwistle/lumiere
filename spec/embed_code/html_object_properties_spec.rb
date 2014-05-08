require_relative '../../lib/embed_code/html_object_properties'

module Lumiere
  describe HTMLObjectProperties do
    describe ".generate" do
      context "no options" do
        subject(:generated_object_properties) { (HTMLObjectProperties.generate) }
        it "returns a blank string" do
          expect(generated_object_properties).to eql('')
        end
      end

      context "options passed" do
        subject(:generated_object_properties) { (HTMLObjectProperties.generate(opts)) }

        context "blank" do
          let(:opts) { { } }
          it 'returns blank string' do
            expect(generated_object_properties).to eql('')
          end
        end

        context "single" do
          let(:opts) { { width: 200 } }
          it 'returns valid object property' do
            expect(generated_object_properties).to eql('width="200"')
          end
        end

        context "multiple" do
          let(:opts) { { width: 200, height: 300 } }
          it 'returns valid object properties' do
            expect(generated_object_properties).to eql('width="200" height="300"')
          end
        end

        context "includes a boolean" do
          let(:opts) { { allowfullscreen: true, height: 300 } }
          context "true" do
            it "returns vaild object properties with just the key and no value" do
              expect(generated_object_properties).to eql('allowfullscreen height="300"')
            end
          end
        end
      end
    end
  end
end
