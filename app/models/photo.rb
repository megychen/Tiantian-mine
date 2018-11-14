class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :certificate

  validates :image, presence: true
end
