class RenameShowToSerie < ActiveRecord::Migration
  def change
    rename_table :shows, :series
    rename_column :episodes, :show_id, :series_id
  end
end
