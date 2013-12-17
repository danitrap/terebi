class AddOverviewThumbAndAirDateToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :overview, :text
    add_column :episodes, :thumb, :text
    add_column :episodes, :air_date, :date
  end
end
