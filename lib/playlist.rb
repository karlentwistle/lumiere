module Lumiere
  module Playlist
    def self.page_count(total, per_page)
      mid_point = total.to_f / per_page.to_f
      mid_point.ceil
    end
  end
end
