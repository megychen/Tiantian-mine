class AddOrderNoToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_no, :string
    add_index :orders, [:user_id]
    add_index :orders, [:order_no], unique: true
  end
end
