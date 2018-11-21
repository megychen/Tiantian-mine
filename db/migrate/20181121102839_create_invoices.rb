class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :user_id
      t.integer :order_id
      t.string :type
      t.string :organization
      t.string :person_name
      t.string :identity_no
      t.string :company_name
      t.string :taxpayer_no
      t.string :receiver_email
      t.string :receiver_name
      t.string :receiver_mobile
      t.string :receiver_province
      t.string :receiver_city
      t.string :receiver_address
      t.string :register_address
      t.string :register_phone
      t.string :deposit_bank
      t.string :bank_no
      t.timestamps
    end
  end
end
