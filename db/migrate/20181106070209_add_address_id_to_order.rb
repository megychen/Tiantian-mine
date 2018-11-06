class AddAddressIdToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :address_id, :integer
    remove_column :orders, :billing_name
    remove_column :orders, :billing_address
    remove_column :orders, :shipping_name
    remove_column :orders, :shipping_address
  end
end
