class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.references :manager, null: false, foreign_key: { to_table: :users }
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :company, null: false, foreign_key: true
      t.timestamps
    end
  end
end
