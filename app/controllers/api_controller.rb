class ApiController < ApplicationController
  # Skip CSRF for API endpoints.
  protect_from_forgery with: :null_session

  before_action :authenticate_user
  

  def me
    if current_user
      render json: current_user
    else
      head :unauthorized
    end
  end
end 