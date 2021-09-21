# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    if user.admin?
      admin_permissions_for_users(user)
      admin_permissions_for_sprint(user)
      admin_permissions_for_project(user)
      admin_permissions_for_issues(user)
      admin_permissions_for_projects_users(user)
      admin_permissions_for_time_logs(user)
      admin_permissions_for_reports(user)
    elsif user.member?
      member_permsisions_for_users(user)
      member_permissions_for_issues(user)
      member_permissions_for_project(user)
      member_permissions_for_sprint(user)
      member_permissions_for_projects_users(user)
      creator_permissions_for_issues(user)
      reviewer_permissions_for_issues(user)
      assignee_permissions_for_issues(user)
      member_permissions_for_time_logs(user)
    end
  end

  def admin_permissions_for_reports(user)
    can :manage, Report, company_id: user.company_id
  end

  def admin_permissions_for_users(user)
    can :manage, User
    unless user.account_owner?
      cannot %i[edit update destroy], User, id: user.company.owner_id
    end
  end

  def admin_permissions_for_projects_users(user)
    can :manage, ProjectsUser, company_id: user.company_id
  end

  def admin_permissions_for_issues(user)
    can :manage, Issue, company_id: user.company_id
  end

  def admin_permissions_for_project(user)
    can %i[update read create delete backlog], Project, company_id: user.company_id
  end

  def admin_permissions_for_time_logs(user)
    can :manage, TimeLog, company_id: user.company_id
  end

  def admin_permissions_for_sprint(user)
    can :manage, Sprint, company_id: user.company_id
  end

  # member permissions
  def member_permsisions_for_users(user)
    can :read, User, company_id: user.company_id
  end

  def member_permissions_for_projects_users(user)
    can %i[read create update destroy], ProjectsUser, project: { manager: user }
    can :read, ProjectsUser, projects_users: { user: user }
  end

  def member_permissions_for_project(user)
    can %i[read update], Project, manager: user, company_id: user.company_id
    can :read, Project, projects_users: { user: user }
  end

  def member_permissions_for_sprint(user)
    can %i[read create update destroy start_sprint start_sprint_info complete_sprint complete_sprint_info], Sprint, project: { manager: user }
    can :read, Sprint, project: { projects_users: user }
  end

  def creator_permissions_for_issues(user)
    can %i[read update destroy], Issue, creator: user, company_id: user.company_id
  end

  def reviewer_permissions_for_issues(user)
    can [:read], Issue, reviewer: user, company_id: user.company_id
  end

  def assignee_permissions_for_issues(user)
    can %i[read update], Issue, creator: user, company_id: user.company_id
  end

  def member_permissions_for_issues(user)
    can :create, Issue, company_id: user.company_id
  end

  def member_permissions_for_time_logs(user)
    can :manage, TimeLog, id: user.id
  end
end
