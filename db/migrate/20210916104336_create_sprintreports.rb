class CreateSprintreports < ActiveRecord::Migration[6.1]
  def change
    create_table :sprintreports do |t|
      t.references :sprint, null: false
      t.references :moved_to, null: true
      t.string :status
      t.references :issue, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
