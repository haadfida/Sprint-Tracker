class ProjectsController < ApplicationController

  load_and_authorize_resource find_by: :sequence_num, through: :current_company
  load_resource :issues, find_by: :sequence_num, through: :project

  # GET /projects
  def index
    binding.pry
    @projects = @projects.includes(:issues).paginate(page: params[:page])
    respond_to do |format|
      format.html
    end
  end

  # GET /projects/new
  def new
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
    @sprints = @project.sprints.includes(:issues).where(status: 'Planning').order(:start_date, :created_at)
    # @sprints = @project.sprints.joins(:issues).group(:id).select('sprints.*, count(*) AS total_issues').where(status: 'Planning').order(:start_date, :creatd_at)
    @issues = @project.issues.where(sprint: nil)

    respond_to do |format|
      format.js
    end
  end

  def active_sprint
    @active_sprint = @project.active_sprint
    unless @active_sprint.nil?
      @issues_to_do = @active_sprint.issues.where(status: 'Open')
      @issues_in_progress = @active_sprint.issues.where(status: 'In Progress')
      @issues_resolved = @active_sprint.issues.where(status: 'Resolved')
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :start_date, :end_date, :manager_id)
  end
end
