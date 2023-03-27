class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :p_name
      t.string :p_price
      t.string :num
      t.string :p_addr

      t.timestamps
    end
  end
end
