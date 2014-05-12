module Lumiere
  share_examples_for "fetched memoized attribute" do |attribute, expected_value|
    let(:remote_attributes) { double(attribute => expected_value) }
    it "returns the video #{attribute}" do
      allow(Fetcher).to receive(:remote_attributes) { remote_attributes }
      expect(subject.send(attribute)).to eql(expected_value)
    end

    it "memomized the call to fetcher" do
      expect(Fetcher).to receive(:remote_attributes).once { remote_attributes }
      2.times do
        subject.send(attribute)
      end
    end
  end
end
