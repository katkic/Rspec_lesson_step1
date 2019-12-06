class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :description, presence: true
  validate :check_expired_at

  enum status: {
    not_started: 0,
    in_progress: 1,
    completed: 2
  }

  scope :search, -> (search_params) do
    return if search_params.blank?

    name_like(search_params[:name]).status_is(search_params[:status]).expired_sort(search_params[:expired_at])
  end

  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :status_is, -> (status) { where(status: status) if status.present? }
  scope :expired_sort, -> (expired_at) { order(expired_at: :desc) if expired_at == 'true' }

  private

  def check_expired_at
    errors.add(:expired_at, 'の日時を正しく入力してください') if expired_at <= Time.now
  end
end
