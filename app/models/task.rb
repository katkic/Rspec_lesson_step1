class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validate :check_expired_at

  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  accepts_nested_attributes_for :labels, reject_if: proc { |attributes| attributes[:name].blank? }
  paginates_per 10

  enum status: {
    not_started: 0,
    in_progress: 1,
    completed: 2
  }

  enum priority: {
    low: 0,
    medium: 1,
    high: 2
  }

  scope :search, -> (search_params) do
    return if search_params.blank?

    where(user_id: search_params[:user_id])
      .name_like(search_params[:name])
      .status_is(search_params[:status])
      .label_is(search_params[:label_id])
      .expired_sort(search_params[:expired_at])
      .priority_sort(search_params[:priority])
  end

  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :status_is, -> (status) { where(status: status) if status.present? }
  scope :label_is, -> (label) { Task.all.joins(:labels).where(labels: { id: label }) if label.present? }
  scope :expired_sort, -> (expired_at) { order(:expired_at) if expired_at == 'true' }
  scope :priority_sort, -> (priority) { order(priority: :desc) if priority == 'true' }

  private

  def check_expired_at
    errors.add(:expired_at, 'の日時を正しく入力してください') if expired_at <= Time.now
  end
end
