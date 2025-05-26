class Todo < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :state, presence: true, inclusion: { in: %w[pending doing done] }

  before_validation :set_default_state, on: :create, if: :new_record?

  scope :by_state, ->(state) { where(state: state) if state.present? }
  scope :search, ->(query) { where("LOWER(name) LIKE ?", "%#{query.downcase}%") if query.present? }

  private

  def set_default_state
    return if state.present?
    self.state = "pending"
  end
end