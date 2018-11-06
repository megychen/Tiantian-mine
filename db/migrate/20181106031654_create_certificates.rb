class CreateCertificates < ActiveRecord::Migration[5.2]
  def change
    create_table :certificates do |t|
      t.string :image
      t.string :name
      t.integer :amount
      t.integer :order_id
      t.timestamps
    end
  end
end
