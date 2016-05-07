Episodes::Internal::AdminUpdater = Struct.new(:episode, :params) do
  def call
    episode.update(params)
  end
end
