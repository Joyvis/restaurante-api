class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
