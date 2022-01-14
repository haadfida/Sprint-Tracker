class AddSeqNumToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :sequence_num, :int, null: false, index: true
  end
end
