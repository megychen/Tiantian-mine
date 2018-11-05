class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :province
      t.string :city
      t.string :district
      t.string :detail
      t.string :zip_code
      t.integer :user_id
      t.timestamps
    end
  end
end
