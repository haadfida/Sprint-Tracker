class AddCompositeEmailCompanyidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, [:company_id, :email], unique: true
  end
end