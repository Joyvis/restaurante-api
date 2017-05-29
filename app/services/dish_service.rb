class DishService
  def create(attributes)
    dish = Dish.new(attributes)
    dish.save    

    dish
  end
  
  def update(attributes, dish)  	
    dish.update_attributes(attributes)    
    dish
  end

  def destroy(dish)  	
    dish.destroy!
  end
end