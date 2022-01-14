class Document < ApplicationRecord
  belongs_to :attachable, polymorphic: true
  has_attached_file :file

  # validates_format_of :attachment_file_name, with: /\.(docx|doc|pdf)/
  validates :file, :attachable, presence: true
  validates_attachment_content_type :file, content_type: ['application/pdf', 'application/doc', 'application/docx',
                                                          'image/jpeg', 'image/gif', 'image/png', 'image/jpg', 'image/bmp']
end
