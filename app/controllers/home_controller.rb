class HomeController < ApplicationController
  def index
    @latest_episodes = Episode.order("updated_at DESC").limit(10)
  end
end
