Episodes::Fetcher = Struct.new(:user_id, :tv_show_id) do
  def call
    tv_show_with_episodes
  end

  private
  def tv_show_with_episodes
    if user_id
      object = Rails.cache.fetch(cache_key) do
        TvShow.eager_load(:user_tv_shows).
          where(id: tv_show_id, user_tv_shows: { user_id: user_id }).
          eager_load(episodes: :user_episodes_for_user_tv_shows).
          last
      end

      Answer.new(object, nil, nil, UserTvShowSerializer)
    else
      Answer.new(
        Rails.cache.fetch(cache_key) do
          TvShow.where(id: tv_show_id).includes(:episodes).last
        end
      )
    end
  end

  def cache_key
    episodes = Episode.where(tv_show_id: tv_show_id)
    "episodes-#{user_id}-#{tv_show_id}-#{episodes.maximum(:updated_at)}"
  end
end
