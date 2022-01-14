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
      admin_permissions_for_documents(user)
      admin_permissions_for_reports
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
      member_permissions_for_documents(user)
    end
  end

  def admin_permissions_for_reports
    can :manage, :report
  end

  def admin_permissions_for_users(user)
    can :manage, User
    unless user.account_owner?
      cannot %i[edit update], User, id: user.company.owner_id
    end
    cannot %i[destroy], User, id: user.company.owner_id
  end

  def admin_permissions_for_projects_users(user)
    can :manage, ProjectsUser, company_id: user.company_id
  end

  def admin_permissions_for_issues(user)
    can :manage, Issue, company_id: user.company_id
  end

  def admin_permissions_for_project(user)
    can :manage, Project, company_id: user.company_id
  end

  def admin_permissions_for_time_logs(user)
    can :manage, TimeLog, company_id: user.company_id
  end

  def admin_permissions_for_sprint(user)
    can :manage, Sprint, company_id: user.company_id
  end

  def admin_permissions_for_documents(user)
    can :manage, Document, company_id: user.company_id
  end

  # member permissions
  def member_permsisions_for_users(user)
    can :read, User, company_id: user.company_id
  end

  def member_permissions_for_projects_users(user)
    can %i[read create update destroy], ProjectsUser, project: { manager_id: user.id }
    can :read, ProjectsUser, user: user
  end

  def member_permissions_for_project(user)
    can %i[read update backlog active_sprint], Project, manager: user, company_id: user.company_id
    can %i[read backlog active_sprint], Project, projects_users: { user: user }
  end

  def member_permissions_for_sprint(user)
    can :manage, Sprint, project: { manager: user }, company_id: user.company_id
    can :read, Sprint, project: { projects_users: { user_id: user.id } }, company_id: user.company_id
  end

  def creator_permissions_for_issues(user)
    can %i[read edit update destroy history], Issue, creator: user, company_id: user.company_id
  end

  def reviewer_permissions_for_issues(user)
    can [:read, :history], Issue, reviewer: user, company_id: user.company_id
  end

  def assignee_permissions_for_issues(user)
    can %i[read update history], Issue, creator: user, company_id: user.company_id
  end

  def member_permissions_for_issues(user)
    can :manage, Issue, project: { manager: user }
    can %i[read create history fetch_resource_issues], Issue, company_id: user.company_id
  end

  def member_permissions_for_time_logs(user)
    can :manage, TimeLog, user_id: user.id, company_id: user.company_id
  end

  def member_permissions_for_documents(user)
    can %i[read create], Document, company_id: user.company_id
  end
end
