TvShows::Internal::JoinDestroyer = Struct.new(:tv_show_id) do
  def call
    UserTvShow.where(tv_show_id: tv_show_id).destroy_all
  end
end
