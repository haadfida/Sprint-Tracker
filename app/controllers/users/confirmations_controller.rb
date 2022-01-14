# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_confirmation_path_for(resource_name, resource)
    return root_url if params[:confirmation_token].blank? || (resource = resource_class.find_by_confirmation_token(params[:confirmation_token])).blank? || resource.has_password?

    # Setting reset_password_token itself to reach reset password screen for the user
    resource = resource_class.find_by(confirmation_token: params[:confirmation_token])
    token    = Devise.token_generator.generate(resource_class, :reset_password_token)
    resource.update_columns({ reset_password_token: token.second, reset_password_sent_at: Time.now.utc })
    edit_user_password_url(resource, reset_password_token: token.first)
  end
end
