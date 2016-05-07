class UserTvShowSerializer < TvShowSerializer
  class EpisodeWithUserWatchedSerializer < EpisodeSerializer
    attributes :watched

    def watched
      object.user_episodes_for_user_tv_shows.last.try(:watched) || false
    end
  end

  has_many :episodes, serializer: EpisodeWithUserWatchedSerializer

  def root
    'tv_show'
  end

  def filter(keys)
    keys
  end
end
