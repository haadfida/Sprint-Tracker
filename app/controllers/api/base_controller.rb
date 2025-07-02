module Api
  class BaseController < ApplicationController
    # Disable CSRF verification for API endpoints so that session cookies created
    # during Devise sign-in remain intact when the React front-end makes
    # subsequent JSON requests from a different origin (localhost:5173).
    # Using `:null_session` would wipe the session and log the user out, which
    # is why POST /api/* requests were failing with "HTTP Origin header didn't
    # match request.base_url".
    skip_before_action :verify_authenticity_token

    before_action :authenticate_user!
    before_action :set_current_user_in_thread

    private

    def set_current_user_in_thread
      Current.user = current_user
    end
  end
end 