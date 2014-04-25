module Lumiere
  module Playlist
    def self.page_count(total, per_page)
      page_count = total / per_page
      page_count += 1 unless total % per_page == 0
      page_count
    end
  end
end
