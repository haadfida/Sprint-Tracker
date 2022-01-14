class AddSprintRefToIssues < ActiveRecord::Migration[6.1]
  def change
    add_reference :issues, :sprint
  end
end
