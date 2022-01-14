# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    begin
      build_resource(user_params)
      resource.company.owner = resource # resource will be an instance of User
      resource.role_id = User::ROLE_ID[:admin]
      resource.skip_confirmation!
      resource.save!
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:error] = e.record.errors.full_messages
      render 'new' and return
    end
    flash[:notice] = t('shared.success.create', resource_label: t('users.user_label'))
    redirect_to new_user_session_url(
      subdomain: resource.company.subdomain,
      email: params[:user][:email]
    )
  end

  def user_params
    params.require(:user).permit(:name,
      :email,
      :password,
      :phone_num,
      company_attributes: [:name, :subdomain])
  end
end
