Episodes::Updater = Struct.new(:current_user, :episode_id, :params) do
  def call
    if current_user.admin?
      Episodes::Internal::AdminUpdater.new(episode, admin_params).call

      Answer.new(episode)
    else
      Episodes::Internal::UserUpdater.new(current_user, episode, watched).call

      Answer.new(
        episode, nil, nil,
        UserTvShowSerializer::EpisodeWithUserWatchedSerializer
      )
    end
  end

  private
  def episode
    @episode ||= Episode.find(episode_id)
  end

  def user_params
    up = ActionController::Parameters.new(params)
    up.require(:episode).require(:watched)
    up.require(:episode).permit(:watched)
  end

  def admin_params
    ActionController::Parameters.new(params).require(:episode).permit(
      :title, :episode
    )
  end

  def watched
    user_params[:watched]
  end
end
