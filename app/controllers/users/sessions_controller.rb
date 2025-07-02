# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :html, :json

  # Disable CSRF checks on JSON requests (API usage)
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  # POST /accounts/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    respond_to do |format|
      format.html { redirect_to after_sign_in_path_for(resource) }
      format.json { render json: resource, status: :created }
    end
  end

  # DELETE /accounts/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

    respond_to do |format|
      format.html { redirect_to after_sign_out_path_for(resource_name) }
      format.json { head :no_content }
    end
  end

  protected

  def after_sign_in_path_for(resource)
    root_url
  end

  def after_sign_out_path_for(resource_or_scope)
    root_url
  end
end
