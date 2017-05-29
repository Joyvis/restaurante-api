Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
  	  namespace :public do
  	  	resources :restaurant, except: [:new, :edit]

  	  	resources :dish, except: [:new, :edit]
  	  end
  	end
  end
end
