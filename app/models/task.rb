class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :duedate, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum priority: { low: 0, medium: 1, high: 2 }
  paginates_per 6
  belongs_to :user
end
