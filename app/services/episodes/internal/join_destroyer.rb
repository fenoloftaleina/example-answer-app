Episodes::Internal::JoinDestroyer = Struct.new(:episode_id) do
  def call
    UserEpisode.where(episode_id: episode_id).destroy_all
  end
end
