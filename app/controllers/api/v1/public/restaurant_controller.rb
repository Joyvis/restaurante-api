module Api
  module V1
    module Public
      class RestaurantController < ApplicationController
        before_action :set_restaurant, only: [:show, :update, :destroy]
        skip_before_action :verify_authenticity_token        

        def index
          @restaurants = Restaurant.all                
        end

        def create
        	@restaurant = RestaurantService.new.create(restaurant_params)

          if @restaurant.valid?
            render json: @restaurant
          else
            render json: {
              message: @restaurant.errors.full_messages,
              fields: @restaurant.errors.messages.keys.map { |k| { k => 'field' } }
            }, status: :unprocessable_entity
          end
        end

        def update             	
        	@restaurant = RestaurantService.new.update(restaurant_params, @restaurant)

          if @restaurant.valid?
            render json: @restaurant
          else
            render json: {
              message: @restaurant.errors.full_messages,
              fields: @restaurant.errors.messages.keys.map { |k| { k => 'field' } }
            }, status: :unprocessable_entity
          end
        end
        
        def show;           
          @restaurant
        end

        def destroy
        	@restaurant = RestaurantService.new.destroy(@restaurant)

          if @restaurant.valid?
            render json: @restaurant
          else
            render json: {
              message: @restaurant.errors.full_messages,
              fields: @restaurant.errors.messages.keys.map { |k| { k => 'field' } }
            }, status: :unprocessable_entity
          end
        end

        private
	        def set_restaurant
	          @restaurant = Restaurant.find(params[:id])          
	        end

	        def restaurant_params        	
	          params.permit(:name)
	        end
	    end
    end
  end
end

