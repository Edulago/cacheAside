class Car < ApplicationRecord
  belongs_to :brand

  enum :status, { available: 0, sold: 1, reserved: 2 }

  validates :model, presence: true
  validates :year, presence: true
  validates :price, presence: true
  validates :mileage, numericality: { greater_than_or_equal_to: 0 }
end
