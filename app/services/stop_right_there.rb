class StopRightThere
  def self.with_permissions(current_user)
    if !current_user.admin?
      return Answer.new('Forbidden', false, 403)
    end

    yield
  end
end
