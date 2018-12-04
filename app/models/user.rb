class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :addresses

  acts_as_messageable

  def admin?
    is_admin
  end

  def mailboxer_email(object)
    email
  end
end
