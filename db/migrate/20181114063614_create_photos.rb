class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :certificate_id
      t.string :image

      t.timestamps
    end
  end
end
