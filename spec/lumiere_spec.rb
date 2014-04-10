require 'spec_helper'

describe Lumiere do

  let(:description) { 'Description of my awesome Video' }
  let(:title) { 'Title of my awesome Video' }
  let(:remote_structure) {
    {
      'entry' => {
        'title' => {'$t' => title},
        'media$group' => {
          'media$description' => {
            '$t' => description
          }
        }
      }
    }
  }

  describe ".fetch_title" do
    it "returns a videos title" do
      video = double(api_url: 'video_hosts_api_url')
      expect(Lumiere).to receive(:remote_structure) { remote_structure }
      expect(Lumiere.fetch_title(video)).to eql(title)
    end
  end

  describe ".fetch_description" do
    it "returns a videos description" do
      video = double(api_url: 'video_hosts_api_url')
      expect(Lumiere).to receive(:remote_structure) { remote_structure }
      expect(Lumiere.fetch_description(video)).to eql(description)
    end
  end

end



