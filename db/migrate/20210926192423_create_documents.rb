class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      # Paperclip columns for file attachment
      t.string :file_file_name, null: false
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
      
      t.references :attachable, polymorphic: true, null: false
      t.references :company, null: false

      t.timestamps
    end
  end
end
