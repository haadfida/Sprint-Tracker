class ReportsController < ApplicationController
  before_action :load_data
  before_action :add_breadcrumbs
  def index
    respond_to do |format|
      format.html
    end
  end

  def sprint
    add_breadcrumb t('sprints.label'), sprint_reports_path
    if params[:sprint_id].present?
      @sprint = @sprints&.find_by(id: params[:sprint_id])
      @sprint_report_attributes = @sprint&.issues.left_outer_joins(:time_logs)&.group('issues.assignee_id')&.select("issues.*, sum(time_logs.logged_time) as total_time_spent, count(*) AS total_issues, count('#{Issue::STATUS[:Resloved]}') as resolved_issues, sum(estimated_time) as total_estimated_time")&.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ReportCsv.new(Report::SPRINT_HEADERS, @sprint_report_attributes).to_csv, type: 'text/csv;', filename: "sprint_report_#{current_user.id}_#{current_company.subdomain}-#{Date.today}.csv" }
    end
  end

  def issues
    add_breadcrumb t('issues.issue_label'), issues_reports_path
    if params[:sprint_id].present?
      @sprint = @sprints&.find_by(id: params[:sprint_id])
      @issue_report_attributes = @sprint&.issues&.order(assignee_id: :desc)&.select('status, assignee_id, priority, category, status, estimated_time, sequence_num, title')&.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ReportCsv.new(Report::ISSUE_HEADERS, @issue_report_attributes).to_csv, type: 'text/csv;', filename: "issue_report_#{current_user.id}_#{current_company.subdomain}-#{Date.today}.csv" }
    end
  end

  def load_data
    @issues = Issue.accessible_by(current_ability)
    @sprints = Sprint.accessible_by(current_ability)
    @users = User.accessible_by(current_ability)
  end

  def reports_param
    params.require(:issue).permit(:sprint_id)
  end

  def add_breadcrumbs
    add_breadcrumb 'Reports', reports_path
  end
end
