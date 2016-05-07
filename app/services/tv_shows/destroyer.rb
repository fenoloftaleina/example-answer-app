TvShows::Destroyer = Struct.new(:current_user, :tv_show_id) do
  def call
    StopRightThere.with_permissions(current_user) do
      if tv_show
        destroy_episodes
        destroy_user_tv_show
        tv_show.destroy
      end

      Answer.new(tv_show)
    end
  end

  private
  def destroy_episodes
    tv_show.episodes.find_each do |episode|
      Episodes::Destroyer.new(current_user, episode.id).call
    end
  end

  def destroy_user_tv_show
    TvShows::Internal::JoinDestroyer.new(tv_show_id).call
  end

  def tv_show
    @tv_show ||= TvShow.find(tv_show_id)
  end
end
