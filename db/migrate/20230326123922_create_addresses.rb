class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :addr_detail
      t.string :person
      t.string :phone
      t.string :post_code

      t.timestamps
    end
  end
end
