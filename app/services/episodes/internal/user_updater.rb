Episodes::Internal::UserUpdater = Struct.new(:user, :episode, :watched) do
  WATCHING = true

  def call
    if watched && !already_watched?
      add_and_or_mark_as_watched
      mark_tv_show_as_watching
    elsif !watched && already_watched?
      mark_as_not_watched
    end
  end

  private
  def already_watched?
    !!user_episode.try(:watched)
  end

  def add_and_or_mark_as_watched
    if !user_episode
      @user_episode = UserEpisode.new(params_hash)
    end

    user_episode.watched = true
    user_episode.save!
  end

  def mark_tv_show_as_watching
    TvShows::Internal::UserUpdater.new(user, episode.tv_show, WATCHING).call
  end

  def mark_as_not_watched
    user_episode.try(:update!, watched: false)
  end

  def user_episode
    @user_episode ||= UserEpisode.find_by(params_hash)
  end

  def params_hash
    { user_id: user.id, episode_id: episode.id }
  end
end
