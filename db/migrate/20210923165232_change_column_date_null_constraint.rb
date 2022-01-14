class ChangeColumnDateNullConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null :issues, :estimated_end_date, true
    change_column_null :issues, :estimated_start_date, true
    change_column_null :issues, :actual_end_date, true
    change_column_null :issues, :actual_start_date, true
  end
end
