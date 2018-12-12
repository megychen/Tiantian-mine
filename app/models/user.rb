class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :addresses
  has_many :invoices
  has_many :logs

  acts_as_messageable

  ROLE = ["manager", "sales"]

  def admin?
    is_admin
  end

  def is_manager?
    role == "manager"
  end

  def is_sales?
    role == "sales"
  end

  def mailboxer_email(object)
    email
  end
end
