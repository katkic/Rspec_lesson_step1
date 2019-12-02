class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :description, presence: true
  validate :check_expired_at



  private

  def check_expired_at
    errors.add(:expired_at, 'の日時を正しく入力してください') if expired_at <= Time.now
  end
end
