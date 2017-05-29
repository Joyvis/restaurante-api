require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  # Verifica se o relacionamento foi criado corretamente
  context 'associations' do
    it { is_expected.to have_many(:dishes) }
  end

  # Verifica as validações do model
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  # Verifica se os campos da tabela foram criados corretamente
  context 'table fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  # Verifica se a ordenação está funcionando
  context 'scopes' do
    describe 'ordered' do
      let!(:restaurant_one) { FactoryGirl.create :restaurant, name: 'Burguer King' }
      let!(:restaurant_two) { FactoryGirl.create :restaurant, name: 'Mc Donalds' }

      it { expect(described_class.ordered).to eq([restaurant_one, restaurant_two]) }
    end
  end

  # Verifica se as factories estão criando corretamente
  context 'factories' do
    it { expect(FactoryGirl.build(:restaurant)).to be_valid }
    it { expect(FactoryGirl.build(:invalid_restaurant)).to_not be_valid }
  end
end
