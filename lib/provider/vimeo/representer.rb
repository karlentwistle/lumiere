module Lumiere
  module VimeoVideoRepresenter
    include Representable::JSON
    include Representable::Coercion

    property :title
    property :description
    property :duration, type: Integer
    property :thumbnail_small
    property :thumbnail_medium
    property :thumbnail_large
  end

  module VimeoVideosRepresenter
    include Representable::JSON::Collection

    items extend: VimeoVideoRepresenter, class: OpenStruct
  end
end
