TvShows::Internal::AdminUpdater = Struct.new(:tv_show, :params) do
  def call
    tv_show.update(params)
  end
end
