module Lumiere

  module YouTubePlaylistRepresenter
    include Representable::JSON
    self.representation_wrap = :feed

    nested 'openSearch$totalResults' do
      include Representable::Coercion
      property :total_results, as: '$t', type: Integer
    end

    nested 'title' do
      property :title, as: '$t'
    end

    nested 'subtitle' do
      property :description, as: '$t'
    end

    nested 'media$group' do
      nested 'media$thumbnail' do
        property :thumbnail_small, :reader => lambda { |doc, args| self.thumbnail_small = doc[0]['url'] }
        property :thumbnail_medium, :reader => lambda { |doc, args| self.thumbnail_medium = doc[1]['url'] }
        property :thumbnail_large, :reader => lambda { |doc, args| self.thumbnail_large = doc[2]['url'] }
      end
    end

    collection :videos, as: :entry, class: OpenStruct do

      nested 'links' do
        property :url, :reader => lambda { |doc, args| self.url = doc[0]['href'] }
      end

      nested 'media$group' do
        nested 'yt$videoid' do
          property :video_id, as: '$t'
        end
      end

    end

  end

end
