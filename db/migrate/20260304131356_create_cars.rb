class CreateCars < ActiveRecord::Migration[8.1]
  def change
    create_table :cars do |t|
      t.references :brand, null: false, foreign_key: true
      t.string :model
      t.integer :year
      t.decimal :price
      t.integer :mileage
      t.string :color
      t.integer :status

      t.timestamps
    end
  end
end
