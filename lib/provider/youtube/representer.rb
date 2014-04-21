module Lumiere
  module YouTubeVideoRepresenter
    include Representable::JSON
    self.representation_wrap = :entry

    nested 'title' do
      property :title, as: '$t'
    end

    nested 'media$group' do
      nested 'media$description' do
        property :description, as: '$t'
      end

      nested 'yt$duration' do
        include Representable::Coercion
        property :duration, as: :seconds, type: Integer
      end

      nested 'media$thumbnail' do
        property :thumbnail_small, :reader => lambda { |doc, args| self.thumbnail_small = doc[0]['url'] }
        property :thumbnail_medium, :reader => lambda { |doc, args| self.thumbnail_medium = doc[1]['url'] }
        property :thumbnail_large, :reader => lambda { |doc, args| self.thumbnail_large = doc[2]['url'] }
      end
    end
  end
end
