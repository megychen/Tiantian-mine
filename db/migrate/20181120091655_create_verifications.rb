class CreateVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :verifications do |t|
      t.string :identity
      t.string :code
      t.timestamps
    end
  end
end
