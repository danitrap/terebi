class AddImdbIdOverviewAndBannerToSeries < ActiveRecord::Migration
  def change
    add_column :series, :imdb_id, :string
    add_column :series, :banner, :string
    add_column :series, :overview, :text
  end
end
