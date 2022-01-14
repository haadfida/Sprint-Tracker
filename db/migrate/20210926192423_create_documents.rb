class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.attachment :file, null: false
      t.references :attachable, polymorphic: true, null: false
      t.references :company, null: false

      t.timestamps
    end
  end
end
