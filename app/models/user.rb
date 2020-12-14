class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  has_many :tasks, dependent: :destroy
  before_destroy :before_admin_destroy
  before_update :before_admin_update

  private
  def before_admin_destroy
    throw(:abort) if User.where(admin: true).count <= 1 && self.admin == true
  end

  def before_admin_update
    if User.where(admin: true).count == 1 && self.admin == false
      errors.add(:admin,"Atleast one admin is required")
      throw(:abort)
    end
  end
end
