class AddRemarkToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remark, :string
  end
end
