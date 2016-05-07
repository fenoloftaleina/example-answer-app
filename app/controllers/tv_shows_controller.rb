class TvShowsController < ApplicationController
  before_action :authenticate_user!

  def index
    TvShows::Fetcher.new(params[:user_id], params[:page]).call.render(self)
  end

  def show
    Answer.new(TvShow.find_by(id: params[:id])).render(self)
  end

  def create
    TvShows::Creator.new(current_user, params).call.render(self)
  end

  def update
    TvShows::Updater.new(current_user, params[:id], params).call.render(self)
  end

  def destroy
    TvShows::Destroyer.new(current_user, params[:id]).call.render(self)
  end
end
