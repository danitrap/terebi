class HomeController < ApplicationController
  def index
    @unseen_episodes = Episode.where(:seen => false).order("air_date DESC")
    @seen_episodes = Episode.where(:seen => true).order("updated_at DESC").limit(10)
    @seen_count = @seen_episodes.count
    @unseen_count = @unseen_episodes.count
    @calendar = Calendar.today
  end
end
