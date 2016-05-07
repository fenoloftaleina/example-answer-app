class EpisodesController < ApplicationController
  before_action :authenticate_user!

  def index
    Episodes::Fetcher.new(params[:user_id], params[:tv_show_id]).call.
      render(self)
  end

  def show
    Answer.new(Episode.find_by(id: params[:id])).render(self)
  end

  def create
    Episodes::Creator.new(current_user, params[:tv_show_id], params).call.
      render(self)
  end

  def update
    Episodes::Updater.new(current_user, params[:id], params).call.render(self)
  end

  def destroy
    Episodes::Destroyer.new(current_user, params[:id]).call.render(self)
  end
end
