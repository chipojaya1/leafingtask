class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :duedate, presence: true

  scope :search_title, -> title { where('title LIKE ?', "%#{title}%") }
  scope :search_status, -> status { where(status: status) }

  scope :priority, -> { order(priority: :desc) }
  enum priority: { low: 0, medium: 1, high: 2 }

  paginates_per 6
end
