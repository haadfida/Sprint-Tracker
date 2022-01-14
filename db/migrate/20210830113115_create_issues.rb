class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :estimated_time, precision: 10, scale: 2
      t.string :status, null: false, index: true
      t.string :priority, null: false, index: true
      t.string :category, null: false, index: true
      t.references :company, null: false
      t.date :estimated_start_date, null: false
      t.date :actual_start_date
      t.date :estimated_end_date, null: false
      t.date :actual_end_date
      t.integer :creator_id, index: true
      t.string :assignee_id, index: true
      t.integer :reviewer_id, index: true
      t.timestamps
    end
  end
end
