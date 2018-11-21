class AddIsConfirmToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :is_confirmed, :boolean, default: false
  end
end
