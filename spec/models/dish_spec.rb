require 'rails_helper'

RSpec.describe Dish, type: :model do
  # Verifica se o relacionamento foi criado corretamente
  context 'associations' do
    it { is_expected.to belong_to(:restaurant) }
  end

  # Verifica as validações do model
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:restaurant_id) }
  end

  # Verifica se os campos da tabela foram criados corretamente
  context 'table fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
    it { is_expected.to have_db_column(:restaurant_id).of_type(:integer) }
  end

  # Verifica se o index da chave estrangeira foi criado
  context 'table indexes' do
    it { is_expected.to have_db_index(:restaurant_id) }
  end

  # Verifica se a ordenação está funcionando
  context 'scopes' do
    describe 'ordered' do
      let!(:dish_one) { FactoryGirl.create :dish, name: 'Frango' }
      let!(:dish_two) { FactoryGirl.create :dish, name: 'Salada' }

      it { expect(described_class.ordered).to eq([dish_one, dish_two]) }
    end
  end

  # Verifica se as factories estão criando corretamente
  context 'factories' do
    it { expect(FactoryGirl.build(:dish)).to be_valid }
    it { expect(FactoryGirl.build(:invalid_dish)).to_not be_valid }
  end
end
