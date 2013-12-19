class AddCachedPostersAndBannersToSeries < ActiveRecord::Migration
  def self.up
    add_attachment :series, :cached_poster
    add_attachment :series, :cached_banner
  end

  def self.down
    remove_attachment :series, :cached_poster
    remove_attachment :series, :cached_banner
  end
end
