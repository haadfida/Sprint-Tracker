class AddRoleIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role_id, :int
  end
end