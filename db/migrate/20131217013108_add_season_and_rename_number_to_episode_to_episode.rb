class AddSeasonAndRenameNumberToEpisodeToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :season, :integer
    rename_column :episodes, :number, :episode
  end
end
