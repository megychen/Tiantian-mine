class Certificate < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :order
  has_many :photos
  accepts_nested_attributes_for :photos

  validates :name, presence: true
  validates :amount, presence: true
end
