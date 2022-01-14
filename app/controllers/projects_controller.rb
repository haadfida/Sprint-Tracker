class ProjectsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_company
  load_resource :issues, find_by: :sequence_num, through: :project
  before_action :add_breadcrumbs, only: [:new, :edit, :index, :show]
  # GET /projects
  def index
    @projects = @projects.includes(:issues).paginate(page: params[:page])
    respond_to do |format|
      format.html
    end
  end

  # GET /projects/new
  def new
    add_breadcrumb t('shared.new'), new_project_path
    respond_to do |format|
      format.html
    end
  end

  # POST /projects/
  def create
    @project.creator = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: t('shared.success.create', resource_label: t('projects.project_label')) }
      else
        format.html do
          flash.now[:error] = @project.errors.full_messages
          render :new
        end
      end
    end
  end

  # GET /projects/:sequence_num/edit
  def edit
    add_breadcrumb t('shared.edit'), edit_project_path
    respond_to do |format|
      format.html
    end
  end

  # POST /projects/:sequence_num/edit
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: t('shared.success.update', resource_label: t('projects.project_label')) }
      else
        format.html do
          flash.now[:error] = @project.errors.full_messages
          render :edit
        end
      end
    end
  end

  # GET /projects/:sequence_num
  def show
    add_breadcrumb @project.name, project_path
    respond_to do |format|
      format.js
      format.html
    end
  end

  # DELETE /projects/:sequence_num
  def destroy
    respond_to do |format|
      if @project.destroy
        format.html { redirect_to projects_url, alert: t('shared.success.delete', resource_label: t('projects.project_label')) }
      else
        format.html do
          flash.now[:error] = @project.errors.full_messages
          render :show
        end
      end
    end
  end

  # GET /projects/:sequence_num/backlog
  def backlog
    @sprints = @project.pending_sprints
    @issues = @project.backlog_issues
    @projects = [@project]
    @users = @current_company.users
    @issues = FilteringParams.new(@issues, params).apply_filters
    respond_to do |format|
      format.js
    end
  end

  # GET /projects/:sequence_num/active_sprint
  def active_sprint
    @active_sprint = @project.active_sprint
    unless @active_sprint.nil?
      @issues = @active_sprint.categorized_issues
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :start_date, :end_date, :manager_id)
  end

  def add_breadcrumbs
    add_breadcrumb t('projects.project_label').pluralize, projects_path
  end
end
