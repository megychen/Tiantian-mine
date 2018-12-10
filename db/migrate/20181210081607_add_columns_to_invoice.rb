class AddColumnsToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :special_company_name, :string
    add_column :invoices, :special_taxpayer_no, :string
  end
end
