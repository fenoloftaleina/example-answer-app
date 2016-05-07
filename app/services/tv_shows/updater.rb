TvShows::Updater = Struct.new(:current_user, :tv_show_id, :params) do
  def call
    if current_user.admin?
      TvShows::Internal::AdminUpdater.new(tv_show, admin_params).call
    else
      TvShows::Internal::UserUpdater.new(current_user, tv_show, watching).call
    end

    Answer.new(tv_show)
  end

  private
  def tv_show
    @tv_show ||= TvShow.find(tv_show_id)
  end

  def user_params
    up = ActionController::Parameters.new(params)
    up.require(:tv_show).require(:watching)
    up.require(:tv_show).permit(:watching)
  end

  def admin_params
    ActionController::Parameters.new(params).require(:tv_show).permit(
      :title, :description, :rank
    )
  end

  def watching
    user_params[:watching]
  end
end
