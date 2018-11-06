class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :name, presence: true
  validates :mobile, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :district, presence: true
  validates :detail, presence: true
end
