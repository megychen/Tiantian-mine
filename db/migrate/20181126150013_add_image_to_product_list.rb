class AddImageToProductList < ActiveRecord::Migration[5.2]
  def change
    add_column :product_lists, :image, :string
  end
end
