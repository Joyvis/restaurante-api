require 'rails_helper'

RSpec.describe Api::V1::Public::RestaurantController, type: :controller do
  let!(:restaurant) { FactoryGirl.create :restaurant }
  
  let(:valid_attributes) { FactoryGirl.attributes_for(:restaurant) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_restaurant) }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all api_v1_public_restaurants as @api_v1_public_restaurants' do
      get :index, session: valid_session, format: :json
      expect(assigns(:restaurants)).to eq([restaurant])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested api_v1_public_restaurant as @api_v1_public_restaurant' do
      get :show, params: { id: restaurant.to_param }, session: valid_session, format: :json
      expect(assigns(:restaurant)).to eq(restaurant)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:attributes) { valid_attributes }

      it 'creates a new Restaurant' do
        expect do          
          post :create, params: attributes , session: valid_session, format: :json
        end.to change(Restaurant, :count).by(1)
      end

      it 'receive RestaurantService.create' do
        expect_any_instance_of(RestaurantService).to receive(:create).and_return(FactoryGirl.create(:restaurant))
        post :create, params: attributes, session: valid_session, format: :json
      end

      it 'update a Restaurant' do
      	patch :update, params: { id: restaurant.to_param, name: 'Sabores do Frango' }, session: valid_session, format: :json            	      	
        expect(assigns(:restaurant).name).to eq('Sabores do Frango')
      end

      it 'destroy a Restaurant' do      	
        expect do          
          delete :destroy, params: { id: restaurant.to_param }, session: valid_session, format: :json            	      	
        end.to change(Restaurant, :count).by(-1)
      end

      it 'assigns a newly created restaurant as @restaurant' do
        post :create, params: attributes, session: valid_session, format: :json
        expect(assigns(:restaurant)).to be_a(Restaurant)
        expect(assigns(:restaurant)).to be_persisted
      end

      it 'redirects to the created restaurant' do
        post :create, params: attributes, session: valid_session, format: :json
        expect(response.status).to eql(200)
      end
    end

    context 'with invalid params' do
      let(:attributes) { invalid_attributes }

      it 'assigns a newly created but unsaved restaurant as @restaurant' do
        post :create, params: attributes, session: valid_session, format: :json
        expect(assigns(:restaurant)).to be_a_new(Restaurant)
      end

      it "re-renders the 'new' template" do
        post :create, params: attributes, session: valid_session, format: :json
        expect(response.status).to eql(422)
      end
    end
  end
end
