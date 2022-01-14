class ChangeDefaultStatusInSprints < ActiveRecord::Migration[6.1]
  def change
    change_column :sprints, :status, :string, default: 'PLANNING'
  end
end
