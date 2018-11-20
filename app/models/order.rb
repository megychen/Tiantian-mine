class Order < ApplicationRecord
  before_create :generate_token
  before_create :generate_order_no
  include AASM

  belongs_to :user
  has_many :product_lists
  has_many :certificates
  belongs_to :address, optional: true

  # def generate_utoken(len = 8)
  #   a = lambda { rand(36).to_s(36) }
  #   token = ""
  #   len.times { |t| token << a.call.to_s }
  #   token
  # end
  #
  # def generate_order_uuid
  #   Date.today.to_s.split('-').join()[2..-1] << generate_utoken(8).upcase
  # end
  #
  def generate_order_no
    self.order_no = RandomCode.generate_order_uuid
  end

  def set_payment_with!(method)
    self.update_columns(payment_method: method)
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
