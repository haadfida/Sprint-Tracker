class ProjectsUsersController < ApplicationController
  load_and_authorize_resource :project, find_by: :sequence_num
  load_and_authorize_resource :projects_user, through: :project, except: :create
  authorize_resource only: :create

  # GET /projects/:sequence_num/projects_users
  def index
    @projects_users = @projects_users.includes(:user).paginate(page: params[:page])
    respond_to do |format|
      format.js
    end
  end

  # GET /projects/:sequence_num/projects_user/new
  def new
    @users = ProjectsUser.users_available_for_project(@current_company, @project)
    respond_to do |format|
      format.js
    end
  end

  # POST /projects/:sequence_num/projects_users
  def create
    user_ids = projects_user_params[:user_id].reject(&:blank?)

    @projects_users, errors = ProjectsUser.add_projects_users(@project, user_ids)
    @projects_users = @projects_users.paginate(page: params[:page])
    respond_to do |format|
      if errors.blank?
        format.js { flash.now[:notice] = t('shared.success.add', resource_label: t('users.label').pluralize) }
      else
        format.js { flash.now[:error] = errors.flatten }
      end
    end
  end

  # DELETE /projects/:sequence_num/projects_user/:user_id/delete
  def destroy
    respond_to do |format|
      if @projects_user.destroy
        format.js { flash.now[:notice] = t('shared.success.delete', resource_label: t('users.label')) }
      else
        format.js { flash.now[:error] = @projects_user.errors.full_messages }
      end
    end
  end

  private

  def projects_user_params
    params.require(:projects_user).permit(user_id: [])
  end
end
