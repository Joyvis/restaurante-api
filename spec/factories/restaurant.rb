FactoryGirl.define do
  factory :restaurant do
    name "Sabores da Carne"    
  end

  factory :invalid_restaurant, class: Restaurant
end