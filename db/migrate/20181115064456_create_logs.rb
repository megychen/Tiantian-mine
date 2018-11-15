class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :model
      t.string :action
      t.timestamps
    end
  end
end
