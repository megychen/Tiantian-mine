class Invoice < ApplicationRecord
  belongs_to :order, optional: true

  validates :type, presence: true
  validates :receiver_name, presence: true
  validates :receiver_mobile, presence: true
  validates :receiver_province, presence: true
  validates :receiver_city, presence: true
  validates :receiver_address, presence: true
end
