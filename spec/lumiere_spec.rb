require 'spec_helper'

describe Lumiere do

  describe ".fetch_title" do
    context "valid" do
      it "returns a videos title" do
        video = double(api_url: 'video_hosts_api_url')
        response = {entry: { title: {'$t' => "My Super Awesome Video"}}}
        expect(Lumiere).to receive(:response) { response }
        expect(Lumiere.fetch_title(video)).to eql('My Super Awesome Video')
      end
    end
  end

end



