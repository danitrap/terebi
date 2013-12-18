class AddSubtitlesToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :subtitles_present, :boolean, default: false
  end
end
