class AddColumnToShoppingCars < ActiveRecord::Migration[5.1]
  def change
    add_column :shopping_cars, :user_id, :integer
  end
end
