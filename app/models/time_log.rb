class TimeLog < ApplicationRecord
  sequenceid :issue, :time_logs

  belongs_to :company
  belongs_to :issue
  belongs_to :assignee, class_name: 'User'

  validates :date, presence: true
  validates :logged_time, numericality: { greater_than: 0 }
end
