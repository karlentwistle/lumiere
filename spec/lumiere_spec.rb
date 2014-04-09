require 'spec_helper'

describe Lumiere do

  describe ".fetch_title" do
    let(:title) { 'Title of my awesome Video' }
    it "returns a videos title" do
      video = double(api_url: 'video_hosts_api_url')
      response = {entry: { title: {'$t'.to_sym => title}}}
      expect(Lumiere).to receive(:remote_structure) { response }
      expect(Lumiere.fetch_title(video)).to eql(title)
    end
  end

  describe ".fetch_description" do
    let(:description) { 'Description of my awesome Video' }
    it "returns a videos description" do
      video = double(api_url: 'video_hosts_api_url')
      response = {entry: { description: {'$t'.to_sym => description}}}
      expect(Lumiere).to receive(:remote_structure) { response }
      expect(Lumiere.fetch_description(video)).to eql(description)
    end
  end

end



