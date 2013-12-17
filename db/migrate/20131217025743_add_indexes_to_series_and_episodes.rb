class AddIndexesToSeriesAndEpisodes < ActiveRecord::Migration
  def change
    add_index :series, [:name, :updated_at]
    add_index :episodes, [:name, :season, :episode, :updated_at]
  end
end
