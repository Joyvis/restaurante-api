class Dish < ApplicationRecord
  belongs_to :restaurant
  
  validates :name, presence: true
  validates :price, presence: true
  validates :restaurant_id, presence: true

  scope :ordered, -> { order(name: :asc) }
end
