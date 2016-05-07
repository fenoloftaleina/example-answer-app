TvShows::Fetcher = Struct.new(:user_id, :page) do
  def call
    Answer.new(
      Rails.cache.fetch(cache_key) do
        paginated(ordered(tv_shows)).to_a
      end
    )
  end

  private
  def tv_shows
    if user_id
      user.tv_shows
    else
      TvShow.all
    end
  end

  def paginated(scope)
    scope.page(page || 1)
  end

  def ordered(scope)
    scope.order(created_at: :desc)
  end

  def user
    User.find(user_id)
  end

  def cache_key
    "tv_shows-#{user_id}-#{page}-#{tv_shows.maximum(:updated_at)}"
  end
end
