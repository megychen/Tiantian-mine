class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  def start!
    self.update_columns(is_maintainable: false)
  end

  def stop!
    self.update_columns(is_maintainable: true)
  end
end
