class Report
  include TimeProgressions
  SPRINT_HEADERS = %w[assignee_name total_issues resolved_issues sum_of_estimated_time total_time_logged].freeze
  ISSUE_HEADERS = %w[status title assignee_name priority category estimated_time total_time_spent].freeze

  def self.sprint_report_data(sprint)
    return if sprint.blank?
    sprint_report_data = sprint.issues.left_outer_joins(:time_logs).group('issues.assignee_id').select("issues.*, sum(time_logs.logged_time) as total_time_logged, count(*) AS total_issues, count('Resloved') as resolved_issues, sum(estimated_time) as sum_of_estimated_time")
  end

  def self.issues_report_data(sprint)
    return if sprint.blank?
    sprint_report_data = sprint.issues.order(assignee_id: :desc)
  end

end
