Episodes::Creator = Struct.new(:current_user, :tv_show_id, :params) do
  def call
    StopRightThere.with_permissions(current_user) do
      Answer.new(create_episode)
    end
  end

  private
  def create_episode
    tv_show.episodes.create(sanitized_params)
  end

  def sanitized_params
    ActionController::Parameters.new(params).require(:episode).permit(
      :title, :episode
    )
  end

  def tv_show
    @tv_show ||= TvShow.find(tv_show_id)
  end
end
