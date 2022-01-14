class DashboardController < ApplicationController
  def index
    add_breadcrumb t('shared.dashboard'), :dashboard_index_url
    load_resources
    respond_to do |format|
      format.html
    end
  end

  def home
    respond_to do |format|
      format.html
    end
  end

  def load_resources
    @projects = @current_company.projects.accessible_by(current_ability)

    @total_sprints = @current_company.sprints.accessible_by(current_ability).size
    @closed_sprints = @current_company.sprints.accessible_by(current_ability).where(status: Sprint::STATUS[:CLOSED]).size

    @total_issues = @current_company.issues.accessible_by(current_ability).size
    @closed_issues = @current_company.issues.accessible_by(current_ability).closed.size
    @in_progress_issues = @current_company.issues.accessible_by(current_ability).in_progress.size
    @in_progress_and_high_priority_issues = @current_company.issues.accessible_by(current_ability).in_progress.high_priority.size

    @assigned_issues = @current_company.issues.accessible_by(current_ability).where(assignee_id: current_user.id).paginate(page: params[:page]) # should include time_logs?
  end
end
