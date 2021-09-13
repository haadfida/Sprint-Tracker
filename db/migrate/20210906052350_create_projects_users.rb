class CreateProjectsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :projects_users do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end