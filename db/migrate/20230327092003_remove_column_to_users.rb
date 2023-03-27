class RemoveColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :Is_admin, :boolean
  end
end
