class ChangeDateToDatetimeInTimeLogs < ActiveRecord::Migration[6.1]
  def change
    change_column :time_logs, :date, :datetime
  end
end
