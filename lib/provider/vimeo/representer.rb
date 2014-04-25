module Lumiere
  module VimeoVideoRepresenter
    include Representable::JSON
    include Representable::Coercion

    property :video_id, as: :id, type: String
    property :title
    property :description
    property :duration, type: Integer
    property :upload_date, type: DateTime
    property :thumbnail_small
    property :thumbnail_medium
    property :thumbnail_large
  end

  module VimeoVideosRepresenter
    include Representable::JSON::Collection

    items extend: VimeoVideoRepresenter, class: Vimeo
  end
end
