class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy, :play, :unsee]

  # GET /episodes
  # GET /episodes.json
  def index
    @series = Series.find(params[:series_id])
    @new_episodes = @series.episodes.where(:seen => false).order("season desc, episode desc")
    @seen_episodes = @series.episodes.where(:seen => true).order("season desc, episode desc")
  end

  # GET /episodes/1
  # GET /episodes/1.json
  def show
  end

  # PUT /episodes/1/play
  def play
    @episode.update_attribute(:seen, true)
    Suby.download_subtitles [@episode.path], lang: (params[:lang] || Settings.get(:subs_locale))
    system "bash", "mpc.sh", "\"#{@episode.path}\""
    redirect_to series_episodes_path(@series)
  end

  def unsee
    @episode.update_attribute(:seen, false)
    redirect_to :back
  end

  # GET /episodes/new
  def new
    @series = Series.find(params[:series_id])
    @episode = @series.episodes.new
  end

  # GET /episodes/1/edit
  def edit
  end

  # POST /episodes
  # POST /episodes.json
  def create
    @series = Series.find(params[:series_id])
    @episode = @series.episodes.new(episode_params)

    respond_to do |format|
      if @episode.save
        format.html { redirect_to series_episode_path(@series, @episode), notice: 'Episode was successfully created.' }
        format.json { render action: 'show', status: :created, location: series_episode_path(@series, @episode) }
      else
        format.html { render action: 'new' }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /episodes/1
  # PATCH/PUT /episodes/1.json
  def update
    respond_to do |format|
      if @episode.update(episode_params)
        format.html { redirect_to series_episode_path(@series, @episode), notice: 'Episode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /episodes/1
  # DELETE /episodes/1.json
  def destroy
    @episode.destroy
    respond_to do |format|
      format.html { redirect_to series_episodes_url(@series) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @series = Series.find(params[:series_id])
      @episode = @series.episodes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params.require(:episode).permit(:name, :episode, :path, :overview, :thumb)
    end
end
