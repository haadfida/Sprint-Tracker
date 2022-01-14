module SprintsHelper
  def project_options_to_add_sprint(projects)
    projects.map { |project| [project.name, project.sequence_num] }
  end

  def complete_sprint_drop_down_options(project)
    project.sprints.where(status: PLANNING).map { |sprint| [sprint.name, sprint.id] }
  end

  def sprint_options_to_add_issues(sprints)
    sprints.map { |sprint| [sprint.name, sprint.sequence_num] }
  end

  def sprints_badge_pill_selection(status)
    case status
    when Sprint::STATUS[:PLANNING] then 'primary'
    when Sprint::STATUS[:ACTIVE] then 'danger'
    when Sprint::STATUS[:CLOSED] then 'success'
    end
  end
end
