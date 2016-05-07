TvShows::Creator = Struct.new(:current_user, :params) do
  def call
    StopRightThere.with_permissions(current_user) do
      Answer.new(create_tv_show)
    end
  end

  private
  def create_tv_show
    TvShow.create(sanitized_params)
  end

  def sanitized_params
    ActionController::Parameters.new(params).require(:tv_show).permit(
      :title, :description, :rank
    )
  end
end
