Episodes::Destroyer = Struct.new(:current_user, :episode_id) do
  def call
    StopRightThere.with_permissions(current_user) do
      if episode
        destroy_user_episodes
        episode.destroy
      end

      Answer.new(episode)
    end
  end

  private
  def destroy_user_episodes
    Episodes::Internal::JoinDestroyer.new(episode_id).call
  end

  def episode
    @episode ||= Episode.find(episode_id)
  end
end
