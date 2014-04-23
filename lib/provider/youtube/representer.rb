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

      collection :thumbnails, class: OpenStruct, as: 'media$thumbnail' do
        property :url
      end
    end
  end
end
