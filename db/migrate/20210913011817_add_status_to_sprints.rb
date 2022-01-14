class AddStatusToSprints < ActiveRecord::Migration[6.1]
  def change
    add_column :sprints, :status, :string
  end
end
