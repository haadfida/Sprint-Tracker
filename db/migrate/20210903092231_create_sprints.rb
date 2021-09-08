class CreateSprints < ActiveRecord::Migration[6.1]
  def change
    create_table :sprints do |t|
      t.date :start_date
      t.date :end_date
      t.date :estimated_start_date
      t.date :estimated_end_date
      t.integer :sequence_num, null: false, index: true
      t.references :project, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
