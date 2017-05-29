require 'rails_helper'

RSpec.describe Api::V1::Public::DishController, type: :controller do
  let!(:dish) { FactoryGirl.create :dish }
  let!(:restaurant) { FactoryGirl.create :restaurant }
  
  let(:valid_attributes) { FactoryGirl.attributes_for(:dish) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_dish) }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all api_v1_public_dishes as @api_v1_public_dishes' do
      get :index, session: valid_session, format: :json      
      expect(assigns(:dishes)).to eq([dish])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested api_v1_public_dish as @api_v1_public_dish' do
      get :show, params: { id: dish.to_param }, session: valid_session, format: :json
      expect(assigns(:dish)).to eq(dish)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:attributes) { valid_attributes.merge(restaurant_id: restaurant.to_param) }

      it 'creates a new Dish' do
        expect do          
          post :create, params: attributes , session: valid_session, format: :json
        end.to change(Dish, :count).by(1)
      end

      it 'receive DishService.create' do
        expect_any_instance_of(DishService).to receive(:create).and_return(FactoryGirl.create(:dish))
        post :create, params: attributes, session: valid_session, format: :json
      end

      it 'update a Dish' do
      	patch :update, params: { id: dish.to_param, name: 'Sabores do Frango' }, session: valid_session, format: :json            	      	
        expect(assigns(:dish).name).to eq('Sabores do Frango')
      end

      it 'destroy a Dish' do      	
        expect do          
          delete :destroy, params: { id: dish.to_param }, session: valid_session, format: :json            	      	
        end.to change(Dish, :count).by(-1)
      end

      it 'assigns a newly created dish as @dish' do
        post :create, params: attributes, session: valid_session, format: :json
        expect(assigns(:dish)).to be_a(Dish)
        expect(assigns(:dish)).to be_persisted
      end

      it 'redirects to the created dish' do
        post :create, params: attributes, session: valid_session, format: :json
        expect(response.status).to eql(200)
      end
    end

    context 'with invalid params' do
      let(:attributes) { invalid_attributes }

      it 'assigns a newly created but unsaved dish as @dish' do
        post :create, params: attributes, session: valid_session, format: :json
        expect(assigns(:dish)).to be_a_new(Dish)
      end

      it "re-renders the 'new' template" do
        post :create, params: attributes, session: valid_session, format: :json
        expect(response.status).to eql(422)
      end
    end
  end
end
