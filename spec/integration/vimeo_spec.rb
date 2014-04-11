require 'spec_helper'

module Lumiere
  describe Vimeo, :vcr do
    subject(:video) { Vimeo.new('4268592') }

    context "4268592" do
      it do
        expect(video.title).to eql('Alan Watts')
        expect(video.description).to eql("Alan Watts&#13;<br />\n&#13;<br />\n&#13;<br />\nSo true.&#13;")
        expect(video.duration).to eql(141)
      end
    end
  end
end



