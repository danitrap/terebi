class AddCachedThumbToEpisode < ActiveRecord::Migration
  def self.up
    add_attachment :episodes, :cached_thumb
  end

  def self.down
    remove_attachment :episodes, :cached_thumb
  end


end
