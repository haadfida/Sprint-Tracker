class ReportsController < ApplicationController
  authorize_resource :current_user
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
      @sprint = fetch_sprint
      @sprint_report_data = Report.sprint_report_data(@sprint)&.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ReportCsv.new(Report::SPRINT_HEADERS, @sprint_report_data).to_csv, type: 'text/csv;', filename: report_filename('sprint') }
    end
  end

  def issues
    add_breadcrumb t('issues.issue_label'), issues_reports_path
    if params[:sprint_id].present?
      @sprint = fetch_sprint
      @issue_report_data = Report.issues_report_data(@sprint)&.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data ReportCsv.new(Report::ISSUE_HEADERS, @issue_report_data).to_csv, type: 'text/csv;', filename: report_filename('issues') }
    end
  end

  def load_data
    @issues = Issue.accessible_by(current_ability)
    @sprints = Sprint.accessible_by(current_ability)
    @users = User.accessible_by(current_ability)
  end

  private
  def report_filename(attribute)
    "#{attribute}_report_#{current_user.id}_#{current_company.subdomain}-#{Date.today}.csv"
  end

  def fetch_sprint
    @sprints.find_by(id: params[:sprint_id])
  end

  def add_breadcrumbs
    add_breadcrumb 'Reports', reports_path
  end
end
