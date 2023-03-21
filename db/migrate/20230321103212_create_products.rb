class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category_id
      t.string :original_price
      t.string :discounted_price
      t.integer :stock

      t.timestamps
    end
  end
end
