class AddNewProductPriceToProductList < ActiveRecord::Migration[5.2]
  def change
    add_column :product_lists, :new_product_price, :integer
  end
end
