require 'spec_helper'

describe Lumiere do

  describe ".fetch_title" do
    context "valid" do
      it "returns the title" do
        require 'json'
        response = {entry: { title: {'$t' => "My Super Awesome Video"}}}.to_json
        allow(Lumiere).to receive(:response).with('VIDEO_ID') { response }
        expect(Lumiere.fetch_title('VIDEO_ID')).to eql('My Super Awesome Video')
      end
    end
  end

end



