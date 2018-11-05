class AddMobileToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :name, :string
    add_column :addresses, :mobile, :string
  end
end
