class ChangeDateFormatInIssues < ActiveRecord::Migration[6.1]

  def up
    change_column :issues, :actual_start_date, :datetime
    change_column :issues, :estimated_start_date, :datetime
    change_column :issues, :actual_end_date, :datetime
    change_column :issues, :estimated_end_date, :datetime
  end
   def down
    change_column :issues, :actual_start_date, :date
    change_column :issues, :estimated_start_date, :date
    change_column :issues, :actual_end_date, :date
    change_column :issues, :estimated_end_date, :date
  end

end
