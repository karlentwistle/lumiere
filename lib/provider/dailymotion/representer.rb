module Lumiere
  module DailymotionVideoRepresenter
    include Representable::JSON
    include Representable::Coercion

    property :video_id, as: :id, type: String
    property :title
    property :description
    property :duration, type: Integer
    property :upload_date, as: :created_time, type: DateTime
    property :thumbnail_small, as: :thumbnail_60_url
    property :thumbnail_medium, as: :thumbnail_240_url
    property :thumbnail_large, as: :thumbnail_720_url
  end

end
