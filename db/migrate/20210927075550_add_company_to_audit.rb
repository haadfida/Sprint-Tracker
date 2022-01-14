class AddCompanyToAudit < ActiveRecord::Migration[6.1]
  def change
    add_column :audits, :company_id, :bigint, null: false, foreign_key: true
  end
end
