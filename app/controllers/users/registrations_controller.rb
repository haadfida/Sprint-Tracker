# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  def create
    build_resource(user_params)
    resource.company.owner = resource # resource will be an instance of User
    resource.role_id = User::ROLE_ID[:admin]
    resource.skip_confirmation!

    if resource.save
      respond_to do |format|
        format.html do
          flash[:notice] = t('shared.success.create', resource_label: t('users.user_label'))
          redirect_to new_user_session_url(
            subdomain: resource.company.subdomain,
            email: params[:user][:email]
          )
        end
        format.json { render json: resource, status: :created }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = resource.errors.full_messages
          render 'new'
        end
        format.json { render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def user_params
    params.require(:user).permit(:name,
      :email,
      :password,
      :phone_num,
      company_attributes: [:name, :subdomain])
  end
end
