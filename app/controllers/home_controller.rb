class HomeController < ApplicationController
  def index
    @all_episodes = Episode.all
    @unseen_episodes = Episode.unseen
    @seen_episodes = Episode.seen
    @calendar = Calendar.today
  end
end
