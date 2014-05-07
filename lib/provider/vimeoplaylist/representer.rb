require 'representable'
require 'representable/coercion'
require 'representable/json'

module Lumiere
  module VimeoPlaylistRepresenter
    include Representable::JSON
    include Representable::Coercion

    property :title
    property :description
    property :upload_date, type: DateTime, as: :created_on
    property :thumbnail_small
    property :thumbnail_medium
    property :thumbnail_large
    property :total_videos, type: Integer
  end
end
