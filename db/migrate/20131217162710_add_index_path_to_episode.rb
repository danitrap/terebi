class AddIndexPathToEpisode < ActiveRecord::Migration
  def change
    add_index :episodes, :path
  end
end
