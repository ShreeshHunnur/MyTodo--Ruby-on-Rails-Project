class Todo < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :state, presence: true, inclusion: { in: %w[pending doing done] }
end