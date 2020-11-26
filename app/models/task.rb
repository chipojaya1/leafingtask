class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :duedate, presence: true

  scope :search_title, -> (params) { where('title LIKE ?', "#{params[:task][:title]}") }
  scope :search_status, -> (params) {where(status: params[:task][:status]) }

  enum priority: { low: 0, medium: 1, high: 2 }

  paginates_per 6
end
