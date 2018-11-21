class Order < ApplicationRecord
  before_create :generate_token
  before_create :generate_order_no
  include AASM

  belongs_to :user
  has_many :product_lists
  has_many :certificates
  has_one :invoice
  belongs_to :address, optional: true

  scope :recent, -> { order("created_at DESC") }

  def generate_token
    self.token = SecureRandom.uuid
  end

  def generate_order_no
    self.order_no = RandomCode.generate_order_uuid
  end

  def set_payment_with!(method)
    self.update_columns(payment_method: method)
  end

  def confirm!
    self.update_columns(is_confirmed: true)
  end

  def pay!
    self.update_columns(is_paid: true)
  end

  def unpay!
    self.update_columns(is_paid: false, aasm_state: "order_placed")
  end

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned


    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid,         to: :shipping
    end

    event :deliver do
      transitions from: :shipping,     to: :shipped
    end

    event :return_good do
      transitions from: :shipped,      to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end

end
