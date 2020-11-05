class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :duedate, presence: true
  validates :status, presence: true
  validates :priority, presence: true
end
