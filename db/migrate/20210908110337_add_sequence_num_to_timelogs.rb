class AddSequenceNumToTimelogs < ActiveRecord::Migration[6.1]
  def self.up
    add_column :time_logs, :sequence_num, :integer, null: false
    update_sequence_num_values
    add_index :time_logs, [:sequence_num,:issue_id], unique: true
  end

  def self.down
    remove_index  :time_logs, column: [:sequence_num, :issue_id]
    remove_column :time_logs, :sequence_num
  end

  def self.update_sequence_num_values
    Issue.all.each do |parent|
      cntr = 1
      parent.timelogs.reorder("id").all.each do |nested|
        nested.sequence_num = cntr
        cntr += 1
        nested.save
      end
    end
  end
end
