class Certificate < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :order

  validates :name, presence: true
  validates :amount, presence: true
  validates :image, presence: true
end
