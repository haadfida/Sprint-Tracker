class SprintsController < ApplicationController
  load_and_authorize_resource :project, find_by: :sequence_num, if: -> { params[:project_id].present? }
  load_and_authorize_resource :sprint, through: :project, find_by: :sequence_num, if: -> { params[:project_id].present? }
  load_and_authorize_resource :sprint, find_by: :sequence_num, if: -> { params[:project_id].blank? }
  before_action :add_breadcrumbs, only: %i[index show report]

  # GET /projects/:sequence_num/sprints
  def index
    @sprints = @sprints.paginate(page: params[:page])
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /projects/:sequence_num/sprints/new
  def new
    @projects = Project.accessible_by(current_ability) if @project.nil?
    respond_to do |format|
      format.js
    end
  end

  # POST /projects/:sequence_num/sprints/new
  def create
    @sprint.creator = current_user
    respond_to do |format|
      if @sprint.save
        format.js { flash.now[:notice] = t('shared.success.create', resource_label: t('sprints.label')) }
      else
        format.js { flash.now[:error] = @sprint.errors.full_messages }
      end
    end
  end

  # GET /projects/:sequence_num/sprints/:sequence_num/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /projects/:sequence_num/sprints/:sequence_num/edit
  def update
    respond_to do |format|
      if @sprint.update(sprint_params)
        format.js { flash.now[:notice] = t('shared.success.update', resource_label: t('sprints.label')) }
      else
        format.js { flash.now[:error] = @sprint.errors.full_messages }
      end
    end
  end

  # GET /projects/:sequence_num/sprints/:sequence_num
  def show
    add_breadcrumb @sprint.name.titleize, sprint_path
    respond_to do |format|
      format.js
      format.html
    end
  end

  # DELETE /projects/:sequence_num/sprints/:sequence_num
  def destroy
    respond_to do |format|
      if @sprint.destroy
        format.js { flash.now[:notice] = t('shared.success.delete', resource_label: t('sprints.label')) }
        format.html { redirect_to sprints_url, notice: t('shared.success.delete', resource_label: t('sprints.label')) }
      else
        format.js { flash.now[:error] = @sprint.errors.full_messages }
        format.html { render :show, error: t('shared.failure.delete', resource_label: t('sprints.label')) }
      end
    end
  end

  # GET sprints/:sequence_num/start_sprint_info
  def start_sprint_info
    respond_to do |format|
      format.js
    end
  end

  # PATCH sprints/:sequence_num/start_sprint
  def start_sprint
    respond_to do |format|
      if @sprint.activate_sprint
        format.js { flash.now[:notice] = t('sprints.started') }
      else
        format.js { flash.now[:error] = @sprint.errors.full_messages }
      end
    end
  end

  # GET sprints/:sequence_num/complete_sprint_info
  def complete_sprint_info
    @issues_unresolved, @issues_resolved = @sprint.resolved_and_unresolved_issues
    respond_to do |format|
      format.js
    end
  end

  # POST sprints/:sequence_num/complete_sprint
  def complete_sprint
    @issues_unresolved, @issues_resolved = @sprint.resolved_and_unresolved_issues
    respond_to do |format|
      if @sprint.complete_sprint(@issues_unresolved, params[:issues_dest])
        format.js
      else
        format.js { flash.now[:error] = @sprint.errors.full_messages }
      end
    end
  end

  # GET sprints/:sequence_num/report
  def report
    @issues_resolved, @issues_unresolved = @sprint.report_content
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def sprint_params
    params.require(:sprint).permit(:name, :description, :start_date, :end_date, :estimated_start_date, :estimated_end_date, :project_id, status: Sprint::STATUS[:PLANNING])
  end

  def add_breadcrumbs
    add_breadcrumb t('sprints.label').pluralize, sprints_path
  end
end
