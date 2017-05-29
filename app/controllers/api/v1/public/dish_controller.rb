module Api
  module V1
    module Public
	  class DishController < ApplicationController
	  	before_action :set_dish, only: [:show, :update, :destroy]
        skip_before_action :verify_authenticity_token
        
        def index
          @dishes = Dish.ordered
        end

        def create
          @dish = DishService.new.create(dish_params)

          if @dish.valid?
            render json: @dish
          else
            render json: {
              message: @dish.errors.full_messages,
              fields: @dish.errors.messages.keys.map { |k| { k => 'field' } }
            }, status: :unprocessable_entity
          end
        end

        def update             	
        	@dish = DishService.new.update(dish_params, @dish)

          if @dish.valid?
            render json: @dish
          else
            render json: {
              message: @dish.errors.full_messages,
              fields: @dish.errors.messages.keys.map { |k| { k => 'field' } }
            }, status: :unprocessable_entity
          end
        end
        
        def show;           
          @dish
        end

        def destroy
        	@dish = DishService.new.destroy(@dish)

          if @dish.valid?
            render json: @dish
          else
            render json: {
              message: @dish.errors.full_messages,
              fields: @dish.errors.messages.keys.map { |k| { k => 'field' } }
            }, status: :unprocessable_entity
          end
        end

        private
	      def set_dish
	        @dish = Dish.find(params[:id])          
	      end

	      def dish_params       	       
	        params.permit(:name, :price, :restaurant_id)
	      end
	  end
    end
  end
end

