class AddDetailToCertificate < ActiveRecord::Migration[5.2]
  def change
    add_column :certificates, :bank_no, :string
    add_column :certificates, :remark, :string
    add_column :certificates, :currency, :string
  end
end
