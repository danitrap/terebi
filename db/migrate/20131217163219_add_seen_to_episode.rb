class AddSeenToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :seen, :boolean, default: false
  end
end
