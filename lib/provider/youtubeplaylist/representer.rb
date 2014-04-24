require_relative '../youtube/youtube'
require_relative '../youtube/representer'

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
      collection :thumbnails, class: OpenStruct, as: 'media$thumbnail' do
        property :url
      end
    end

    collection :videos, as: :entry, extend: YouTubeVideoRepresenter, class: YouTube
  end

end
