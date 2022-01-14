class Sprint < ApplicationRecord
  searchkick word_middle: %i[name description], filterable: %i[company_id]
  include DateValidations

  belongs_to :company
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  sequenceid :company, :sprints

  has_many :issues
  has_many :sprint_report_items, class_name: 'Sprintreport', dependent: :destroy
  has_many :documents, as: :attachable, dependent: :destroy
  has_many :sprint_report_issues, through: :sprint_report_items, source: :issue

  STATUS = { PLANNING: 'PLANNING', ACTIVE: 'ACTIVE', CLOSED: 'CLOSED' }.freeze

  validates :name, :project_id, :start_date, :end_date, :creator_id, presence: true
  validate_datetime :start_date
  validate_datetime :end_date
  validate_datetime :estimated_start_date
  validate_datetime :estimated_end_date
  validate_dates :start_date, :end_date
  validate_dates :estimated_start_date, :estimated_end_date
  validates :status, inclusion: { in: STATUS.values }

  before_destroy :check_for_issues, prepend: true

  def total_time_spent
    issues.joins(:time_logs).sum(:logged_time)
  end

  def total_estimated_time
    issues.sum(:estimated_time)
  end

  def activate_sprint
    begin
      transaction do
        if project.active_sprint.nil?
          if project.update!(active_sprint: self)
            update!(status: Sprint::STATUS[:ACTIVE])
          end
        else
          errors.add :project, I18n.t('sprints.active_sprint_exists')
          false
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add :base, e.record.errors.full_messages
      false
    end
  end

  def complete_sprint(issues, issues_dest_id)
    begin
      transaction do
        generate_report
        issues.each do |issue|
          Sprintreport.find_by(sprint: self, issue: issue).update(status: Sprintreport::STATUS[:MOVED], moved_to_id: issues_dest_id)
        end
        issues_dest_id.blank? ? issues.update(sprint: nil) : issues.update(sprint_id: issues_dest_id)
        project.update!(active_sprint: nil)
        update!(status: Sprint::STATUS[:CLOSED])
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add :base, e.record.errors.full_messages
      false
    end
  end

  def generate_report
    return if sprint_report_items.presence

    begin
      transaction(requires_new: true) do
        sprintreport_objects = []
        issues.each do |issue|
          sprintreport_objects << { sprint_id: id, issue_id: issue.id, status: (issue.status == Issue::STATUS.key('Closed') ? Sprintreport::STATUS[:CLOSED] : Sprintreport::STATUS[:IN_PROGRESS]) }
        end
        Sprintreport.create!(sprintreport_objects)
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add :base, e.record.errors.full_messages
      false
    end
  end

  def resolved_and_unresolved_issues
    issues_unresolved = issues.where.not(status: Issue::STATUS.invert['Closed'])
    issues_resolved = issues.where(status: Issue::STATUS.invert['Closed'])
    [issues_unresolved, issues_resolved]
  end

  def report_content
    generate_report
    issues_unresolved = sprint_report_items.includes(:issue).unresolved_issues
    issues_resolved = sprint_report_items.includes(:issue).closed_issues
    [issues_resolved, issues_unresolved]
  end

  def categorized_issues
    issues_to_do = issues.open
    issues_in_progress = issues.in_progress
    issues_resolved = issues.resolved
    issues_closed = issues.closed
    { to_do: issues_to_do, in_progress: issues_in_progress, resolved: issues_resolved, closed: issues_closed }
  end

  private

  def check_for_issues
    return if issues.blank?

    errors.add(:base, I18n.t('sprints.sprint_deletion_error'))
    throw :abort
  end
end
