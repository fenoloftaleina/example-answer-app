class ApplicationController < ActionController::API
  include ActionController::Serialization

  acts_as_token_authentication_handler_for User

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def record_not_found(e)
    Answer.new(e.message, false, 404).render(self)
  end

  def parameter_missing(e)
    Answer.new(e.message, false, 400).render(self)
  end
end
