class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :check_last_admin

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, allow_blank: true },
                    uniqueness: true
  validates :password, length: { minimum: 8, allow_blank: true }

  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  has_secure_password
  paginates_per 15

  private

  def check_last_admin
    throw :abort if self.admin? && User.where(admin: true).size == 1
  end
end
