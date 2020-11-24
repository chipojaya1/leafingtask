class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :duedate, presence: true

  scope :search_status, -> (status){where('status = ?',status)}
  scope :search_title, -> (title){where('title LIKE ?',"%#{title}%")}
end
