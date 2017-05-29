FactoryGirl.define do
  factory :dish do
    name "Arroz"
    price 10.75
    association :restaurant, factory: :restaurant
  end

  factory :invalid_dish, class: Dish do
    name "Arroz"
    price 10.75
  end
end