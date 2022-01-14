class UsersController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_company
  before_action :add_breadcrumbs, only: [:new, :edit, :index, :show]

  def index
    @users = @users.paginate(per_page: RECORDS_PER_PAGE, page: params[:page])
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params) }
    end
  end

  def show
    add_breadcrumb @user.name, user_path
    respond_to do |format|
      format.html
    end
  end

  def new
    add_breadcrumb t('shared.new'), new_user_path
    respond_to do |format|
      format.html
    end
  end

  def create
    @user.new_member = true
    respond_to do |format|
      if @user.save

        format.html { redirect_to @user, notice: t('shared.success.create', resource_label: t('users.label')) }
      else
        flash.now[:error] = @user.errors.full_messages
        format.html { render :new }
      end
    end
  end

  def edit
    add_breadcrumb t('shared.edit'), edit_user_path
    respond_to do |format|
      format.html
    end
  end

  def update
    @user.new_member = true if @user.has_password?
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t('shared.success.update', resource_label: t('users.label')) }
      else
        flash.now[:error] = @user.errors.full_messages
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url, alert: t('shared.success.delete', resource_label: t('users.label')) }
      else
        flash.now[:error] = @user.errors.full_messages
        format.html { render :show }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :phone_num,
      :role_id
    )
  end

  def add_breadcrumbs
    add_breadcrumb t('users.label'), users_path
  end
end
