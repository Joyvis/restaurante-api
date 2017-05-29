class RestaurantService
  def create(attributes)
    restaurant = Restaurant.new(attributes)
    restaurant.save    

    restaurant
  end
  
  def update(attributes, restaurant)  	
    restaurant.update_attributes(attributes)    
    restaurant
  end

  def destroy(restaurant)  	
    restaurant.destroy!
  end
end