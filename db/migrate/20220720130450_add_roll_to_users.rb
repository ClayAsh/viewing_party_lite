class AddRollToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :roll, :integer, default: 0
  end
end
