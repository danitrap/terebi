class HomeController < ApplicationController
  def index
    @unseen_episodes = Episode.unseen
    @seen_episodes = Episode.seen
    @seen_count = @seen_episodes.count
    @unseen_count = @unseen_episodes.count
    @calendar = Calendar.today
  end
end
