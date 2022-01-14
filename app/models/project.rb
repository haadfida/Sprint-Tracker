class Project < ApplicationRecord

  include DateValidations
  include TimeProgressions
  searchkick word_middle: %i[name], filterable: %i[company_id]

  before_destroy :check_for_sprints, :check_for_issues

  belongs_to :company
  belongs_to :manager, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  belongs_to :active_sprint, class_name: 'Sprint', optional: true

  has_many :issues
  has_many :sprints
  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users, dependent: :destroy

  sequenceid :company, :projects

  validates :name, :manager, :creator, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }
  validate_datetime :start_date
  validate_datetime :end_date
  validate_dates :start_date, :end_date

  def total_time_spent
    if issues.any?
      issues.sum(:estimated_time)
    end
  end

  def total_logged_time
    TimeLog.joins(:issue).sum(:logged_time)
  end

  def total_time_spent
    total_time = 0
    if issues.any?
      total_time = TimeLog.joins(:issue).sum(:logged_time)
    end
  end

  def total_estimated_time
    total_time = 0
    if issues.any?
      total_time = issues.sum(:estimated_time)
    end
  end

  def self.project_lead_fetch_sprints
    @current_company.projects.where(manager: current_user)
  end

  def sprints_and_issues
    sprints = self.sprints.includes(:issues).where(status: Sprint::STATUS[:PLANNING]).order(:start_date, :created_at)
    issues = self.issues.where(sprint: nil)
    [sprints, issues]
  end

  def pending_sprints
    sprints.includes(:issues).where(status: Sprint::STATUS[:PLANNING]).order(:start_date, :created_at)
  end

  def backlog_issues
    issues.where(sprint_id: nil)
  end

  def fetch_project_issues
    if active_sprint.present?
      active_sprint.issues
    end
  end

  def fetch_sprint_issues
    if active_sprint.present?
      active_sprint.issues
    end
  end

  private

  def check_for_sprints
    return unless sprints.exists?

    errors.add(:base, I18n.t('projects.deletion_error'))
    throw :abort
  end

  def check_for_issues
    return unless issues.exists?

    errors.add(:base, I18n.t('issues.deletion_error'))
    throw :abort
  end
end
