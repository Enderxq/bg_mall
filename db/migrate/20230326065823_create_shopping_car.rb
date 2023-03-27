class CreateShoppingCar < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cars do |t|
      t.string :p_name
      t.integer :p_num
      t.integer :p_price
    end
  end
end
