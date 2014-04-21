module Lumiere
  module VimeoVideoRepresenter
    include Representable::JSON

    property :title
    property :description
    property :duration
    property :thumbnail_small
    property :thumbnail_medium
    property :thumbnail_large
  end

  module VimeoVideosRepresenter
    include Representable::JSON::Collection

    items extend: VimeoVideoRepresenter, class: OpenStruct
  end
end
