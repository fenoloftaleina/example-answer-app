TvShows::Internal::UserUpdater = Struct.new(:user, :tv_show, :watching) do
  def call
    if watching && !already_watching?
      add
    elsif !watching && already_watching?
      remove
    end
  end

  private
  def already_watching?
    user.tv_shows.where(id: tv_show.id).exists?
  end

  def add
    user.tv_shows << tv_show
  end

  def remove
    UserTvShow.find_by(user_id: user.id, tv_show_id: tv_show.id).destroy
  end
end
