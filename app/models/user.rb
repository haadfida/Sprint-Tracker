class User < ApplicationRecord
  searchkick word_middle: %i[name email], filterable: %i[company_id]

  sequenceid :company, :users
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  before_destroy :check_dependent_resources?, prepend: true

  belongs_to :company

  has_many :assigned_issues, class_name: 'Issue', foreign_key: 'assignee_id', dependent: :nullify
  has_many :created_issues, class_name: 'Issue', foreign_key: 'creator_id', dependent: :nullify
  has_many :reviewed_issues, class_name: 'Issue', foreign_key: 'reviewer_id', dependent: :nullify
  has_many :projects_users, dependent: :nullify
  has_many :projects, through: :projects_users
  has_many :time_logs, foreign_key: 'assignee_id', dependent: :nullify

  accepts_nested_attributes_for :company

  validate :change_self_role
  validates :email, presence: true, uniqueness: { scope: :company_id }
  validates :password, presence: true, length: { minimum: 6, maximum: 128 }, unless: -> { new_member }
  validates :phone_num, presence: true, length: { minimum: 6, maximum: 15 }
  validates :name, presence: true, length: { minimum: 2, maximum: 40 }
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates_format_of :phone_num, with: /\A\+?\d{7}\d*\z/

  ROLE_ID = { admin: 1, member: 2 }.freeze
  validates :role_id, presence: true, inclusion: { in: ROLE_ID.values }

  attr_accessor :new_member

  def has_password?
    encrypted_password.present?
  end

  def account_owner?
    id == company.owner_id
  end

  def admin?
    role_id == ROLE_ID[:admin]
  end

  def member?
    role_id == ROLE_ID[:member]
  end

  def role_name
    if account_owner?
      I18n.t('roles.account_owner')
    elsif admin?
      I18n.t('roles.admin')
    else
      I18n.t('roles.member')
    end
  end

  def password_required?
    return false if new_member

    super
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  private

  def check_dependent_resources?
    if assigned_issues.any?
      self.errors.add(:base, "Can't be destroyed because User is assigned an issue")
      throw :abort
    elsif reviewed_issues.any?
      self.errors.add(:base, "Can't be destroyed because User is reviewing an issue")
      throw :abort
    elsif time_logs.any?
      self.errors.add(:base, "Can't be destroyed because User is working on an issue")
      throw :abort
    end
  end

  def change_self_role
    return if Current.user.nil? || Current.user.id != id || changes[:role_id].blank?

    errors.add :base, I18n.t('users.self_role_id_change_error')
  end
end
