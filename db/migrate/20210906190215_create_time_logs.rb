class CreateTimeLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :time_logs do |t|
      t.date :date
      t.decimal :logged_time, precision: 10, scale: 2, null: false
      t.text :work_description, null: false
      t.references :company, null: false, foreign_key: true
      t.references :issue, null: false, foreign_key: true
      t.references :assignee, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
