class Restaurant < ApplicationRecord
  has_many :dishes

  validates :name, presence: true
  scope :ordered, -> { order(name: :asc) }
end
