module Lumiere
  module YouTubeVideoRepresenter
    include Representable::JSON
    nested 'title' do
      property :title, as: '$t'
    end

    nested 'published' do
      include Representable::Coercion
      property :upload_date, as: '$t', type: DateTime
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

  module YouTubeVideoEntryRepresenter
    include Representable::JSON
    nested 'entry' do
      include YouTubeVideoRepresenter
    end
  end

end
