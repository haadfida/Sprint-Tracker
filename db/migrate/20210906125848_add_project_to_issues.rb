class AddProjectToIssues < ActiveRecord::Migration[6.1]
  def change
    add_reference :issues, :project, null: true, foreign_key: true
  end
end
