class AddIsMaintainableToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :is_maintainable, :boolean, default: false
  end
end
